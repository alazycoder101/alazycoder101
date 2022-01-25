# 用堆栈来转换为二进制
from pythonds.basic import Stack
def baseConverter(decNumber, base):
    digits = "0123456789ABCDEF"

    remstack = Stack()

    while decNumber > 0:
        rem = decNumber % base
        remstack.push(rems)
        decNumber = decNumber // 2
    
    binString = ""
    while not remstack.isEmpty():
        binString = binString + str(remstack.pop())

    return binString