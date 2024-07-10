def compute_primes
  fibers = NR_CORES.times.map do |i|
    Fiber.new do
      partition = PARTITIONED[i]
      partition.each { |n|
        Fiber.yield if prime?(n)
      }
    end
  end


  running = true


  while running
    dead = 0
    fibers.each { |f|
      if f.alive?
        f.resume
      else
        dead += 1
      end
    }
    running = false if dead == fibers.size
  end
end


def filter_primes
  result = []
  fibers = NR_CORES.times.map do |i|
    Fiber.new do
      partition = PARTITIONED[i]
      partition.each { |n|
        Fiber.yield(n) if prime?(n)
      }
      nil # final resume
    end
  end


  running = true


  while running
    dead = 0
    fibers.each { |f|
      if f.alive?
        prime = f.resume
        result << prime if prime
      else
        dead += 1
      end
    }
    running = false if dead == fibers.size
  end
end
