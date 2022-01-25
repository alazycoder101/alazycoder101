class Fraction
  attr_accessor :num, :den

  def initialize(top, bottom)
    self.num = top
    self.den = bottom
  end

  def to_s
    "#{num}/#{den}"
  end

  def +(other)
    newnum = num * other.den + den * other.num
    newden = den * other.den
    Fraction.new(newnum, newden)
  end

  def ==(other)
    firstnum = num * other.den
    secondnum = other.num * den
    firstnum == secondnum
  end
end

f1 = Fraction.new(1, 4)
f2 = Fraction.new(1, 2)
f3 = f1 + f2
puts f1.to_s
puts f3.to_s
f2 = f1
puts f1 == f2
f2 = Fraction.new(1, 4)
puts f1 == f2
