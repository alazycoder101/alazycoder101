a_list = [2, 3, 7, None]
tup = ('foo', 'bar', 'baz')
b_list = list(tup)
b_list[1] = 'peekaboo'
# insert的操作消耗比append大
b_list.append('abcd')
b_list.insert(1, 'red')

b_list.pop(2)

# colections.deque
b_list.remove('foo')

'a' in b_list

# 联合列表
[4, None, 'foo'] + [7, 8, (2, 3)]

x = [4, None, 'foo']
x.extend([7, 8, (2, 3)])

# 请注意通过添加内容来连接列表是一种相对高代价的操作，这是因为连接过程中创建了新列表，并且还要复制对象。使用extend将元素添加到已经存在的列表是更好的方式，尤其是在你需要构建一个大型列表时：
everything = []
for chunk in list_of_lists:
    everything.extend(chunk)

everything = []
for chunk in list_of_lists:
    everything = everything + chunk

# 排序
a = [7, 2, 5, 1, 3]
a.sort()

b = ['saw', 'small', 'He', 'foxes', 'six']
b.sort(key=len)

# 二分搜索和已排序列表的维护

import bisect
c = [1, 2, 2, 2, 3, 4, 7]
bisect.bisect(c, 2)

bisect.bisect(c, 5)
bisect.insort(c, 6)

# 切片
seq = [7, 2, 3, 7, 5, 6, 0, 1]
seq[1:5]

seq[3:4] = [6, 3]

seq[:5]
seq[3:]
seq[-4:]
seq[-6:-2]

# step 2
seq[::2]

# reverse
seq[::-1]
