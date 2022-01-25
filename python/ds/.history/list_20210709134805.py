sqlist=[x*x for x in range(1,11)]
sqlist=[x*x for x in range(1,11) if x%2!=0]
[ch.upper for ch in 'comprehension' if ch not in 'aeiou']

anumber=int(input("Please enter an integer"))
if anumber < 0:
	raise RuntimeError("You can't use a negative number")
else:
	print(math.sqrt(answer))

def test1():
	l = []
	for in in range(1000):
		l = l + [i]

def test2():
	l = []
	for in in range(1000):
		l.append(i)

def test3():
	l = [i for i in range(1000)]

def test4():
	l = list(range(1000))

t1 = Timer("test1()", "from __main__ import test1")
print("concat ", t1.timeit(number=1000), "milliseconds")

t2 = Timer("test2()", "from __main__ import test1")
print("concat ", t2.timeit(number=1000), "milliseconds")

t3 = Timer("test3()", "from __main__ import test1")
print("concat ", t3.timeit(number=1000), "milliseconds")