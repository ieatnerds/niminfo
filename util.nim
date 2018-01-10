# This utility file will implement several psutil function that i'd like.
# i'd just use psutil, but it seems that it is currently broken. and I dont feel 
# like fixing it myself for the time being.

import strutils, sequtils, sets, tables, math

const memFile = "/proc/meminfo"

proc memInfo(): void =
  for line in lines memFile:
    echo line

proc totalMemInfo(): string = 
# Returns in megabytes the amount of ram installed. 
# If it cant we  return nil, whether thats good or not is up
# to the user of this.
  for line in lines memFile:
    if line.startsWith("MemTotal:"):
      var info = line.split().deduplicate()
      for x in info: # Tried to do sequtil filter ,but couldn't get it to work properly
        try:
          var x = parseInt(x) / 1024
          return cast[string](x)
        except:
          continue
  return nil

proc boot_time*(): float =
  ## Return the system boot time expressed in seconds since the epoch
  let stat_path = "/proc/stat"
  for line in stat_path.lines:
    if line.startswith("btime"):
      return line.strip().split()[1].parseFloat()

  raise newException(OSError, "line 'btime' not found in $1" % stat_path)

proc cpu_count_physical*(): int =
  ## Return the number of physical cores in the system.
  var mapping = initTable[int, int]()
  var current_info = initTable[string, int]()
  for raw_line in lines("/proc/cpuinfo"):
    let line = raw_line.strip().toLowerAscii()
    if line == "":
       # new section
      if "physical id" in current_info and "cpu cores" in current_info:
            mapping[current_info["physical id"]] = current_info["cpu cores"]
      current_info = initTable[string, int]()
    else:
      # ongoing section
      if line.startswith("physical id") or line.startswith("cpu cores"):
        let parts = line.split("\t:")
        current_info[parts[0].strip()] = parseInt(parts[1].strip())

  let values = toSeq(mapping.values())
  return sum(values)

if isMainModule == true:
  memInfo()
  echo totalMemInfo()
  echo boot_time()
  echo cpu_count_physical()
  