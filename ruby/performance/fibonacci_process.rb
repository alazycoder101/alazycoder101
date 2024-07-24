require "gvl-tracing"

def fib(n)
  return n if n <= 1
  fib(n - 1) + fib(n - 2)
end

NR_CORES = 6

def calc
  result = []
  pipes = []
  pids = []

  NR_CORES.times do |i|
    pid = fork do
      fib(37)
    end
    pids << pid
  end

  pids.each do |pid|
    Process.waitpid(pid)
  end
end

GvlTracing.start("fab_process.json") do
  calc
end
