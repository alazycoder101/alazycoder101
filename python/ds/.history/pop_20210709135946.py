import timeit
popzero = timeit.Timer("x.pop(0)", "from __main__ import x")
popend = timeit.Timer("x.pop()", "from __main__ import x")

x = list(range(2000000))
print(popzero.timeit(number=1000))

x = list(range(2000000))
print(popend.timeit(number=1000))

# 比较不同列表长度下的性能
print("比较不同列表长度下的性能")
print("pop(0) pop()")
for i in range(1000000, 10000001, 1000000):