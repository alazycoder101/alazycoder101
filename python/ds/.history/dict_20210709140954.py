import timeit
import random

for i in range(10000, 1000001, 20000):
    t = timeit.Time("random.randrange(%d) in x" % i, "from __main__ import random, x")

    x = list(range(i))
    lst_time = t.timeit(number=1000)
    x = {j:None for j in range(i)}