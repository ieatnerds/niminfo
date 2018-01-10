# Nichoals Kelly
# This will be for several things I'd like to test out for nim. mostly several pieces of the
# standard library as well as some other libraries from nimble

# If you wish to use this please make sure all the following libs are installed
import cpuinfo, times, terminal, posix, colorize, eternity, util# psutil


proc getCpuInfo(): void =
  # shows several bits of information about the processor
  # (and some other info about the rest of the hardware)
  echo("\nCPU INFO-------------------------".fgBlue)
  echo("Number of processors:", countProcessors())
  echo("Physical Processors:", cpu_count_physical())
  echo("CPU Type:", hostCPU)

proc getSysInfo(): void =
  # This will show several fnction related more to the system rather than
  # the hardware, such as stacktrace.
  echo("\nSYS INFO-------------------------".fgBlue)
  echo("StackTrace:", getStackTrace())
  echo("Free Mem of process:", getFreeMem())
  echo("Number of bytes Used:", getOccupiedMem())
  echo("Total Mem of the process:", getTotalMem())
  echo("System RAM(m):", util.totalMemInfo())
  echo("Endian Type:", cpuEndian)
  echo("OS Type:", hostOS)
  echo("Is Main:", isMainModule)
#  echo net_if_addrs()
#  echo boot_time()
#  echo users()

proc getMscInfo(): void =
  # This will be used to get other misc information, such as epoch time
  echo("\nMSC INFO-------------------------".fgBlue)
  echo("Time since the epoch:", epochTime())
  echo("CPU Time:", cpuTime())
  echo("CPU Time:", humanize(cpuTime()))
  echo("Terminal Height:", terminalHeight(), " | Terminal Width:", terminalWidth())
  echo("Proc UID:", getUid())
  echo("Login:", getLogin())
  echo("App Type:", appType)
  echo("Compile Time:", CompileTime)
  echo("Compile Date:", CompileDate)

proc main(): void =
  getCpuInfo()
  getSysInfo()
  getMscInfo()

main()