tup = 1, 2, 3
nested_tup = (4, 5, 6), (7, 8)
tup = tuple([1, 2, 3])
tup = tuple('string')
print(tup[0])

tup = tuple(['foo', [1, 2], True])
print(tup)
tup[1].append(3)
print(tup)

# 元组拆包
tup = (4, 5, 6)
a, b, c = tup
tup = 4, 5, (6, 7)
a, b, (c, d) = tup
a, b = 1, 2


seq = [(1, 2, 3), (4, 5, 6), (7, 8, 9)]
for a, b, c in seq:
  print('a={0}, b={1}, c={2}'.format(a, b, c))

values = 1,2, 3, 4, 5
a, b, *rest = values
# 元组方法

a = (1, 2, 2, 2, 3, 4, 2)
a.count(2)


