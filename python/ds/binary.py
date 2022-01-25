# 用堆栈来转换为二进制
from pythonds.basic import Stack
def divideBY2(decNumber):
    remstack = Stack()

    while decNumber > 0:
        rem = decNumber % 2
        remstack.push(rems)
        decNumber = decNumber // 2
    
    binString = ""
    while not remstack.isEmpty():
        binString = binString + str(remstack.pop())

    return binString
