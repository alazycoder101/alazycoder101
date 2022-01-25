def gcd(m, n):
	while m%n != 0:
		oldm = m
		oldn = n

		m = oldn
		n = oldm%oldn
	return n 
class Fraction:
	
	def __init__(self, top, bottom):
		self.num = top
		self.den = bottom

	def show(self):
		print(self.num, "/", self.den)

	def __str__(self):
		return str(self.num) + "/" + str(self.den)
	

	def __add__(self, otherfraction):
		newnum = self.num * otherfraction.den + \
				self.den * otherfraction.num
		newden = self.den * otherfraction.den
		common = gcd(newnum, newden)
		return Fraction(newnum/common, newden/common)

f1 = Fraction(1, 4)
f2 = Fraction(1, 2)
f3 = f1 + f2
print(f3)
f2 = f1
# 浅相等
f2 = Fraction(1, 4)
print("前相等：同一个对象f1==f2", f1==f2, f1, f2)