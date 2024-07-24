require 'gvl-tracing'

def fib n
  if n < 2
    1
  else
    fib(n-2) + fib(n-1)
  end
end

RN = 6
def ractor
  rs = (1..RN).map do |i|
    Ractor.new i do |i|
      [i, fib(37)]
    end
  end

  until rs.empty?
    r, v = Ractor.select(*rs)
    rs.delete r
    #p answer: v
  end
end

GvlTracing.start("example3.json") do
  ractor
end
