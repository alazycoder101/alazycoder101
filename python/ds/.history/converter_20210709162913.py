# 用堆栈来转换为二进制
from pythonds.basic import Stack
def baseConverter(decNumber, base):
    digits = "0123456789ABCDEF"

    remstack = Stack()

    while decNumber > 0:
        rem = decNumber % base
        remstack.push(rems)
        decNumber = decNumber // base
    
    newString = ""
    while not remstack.isEmpty():
        newString = newString + digits[remstack.pop()]

    return binString