from pythonds.basic import Stack
def parChecker(symbolString):
    s = Stack()
    balanced = True
    index = 0
    while index < len(symbolString) and balanced:
        symbol = symbolString[index]
        if symbol == "(":
            s.push(symbo)
        else:
            if s.isEmpty():
                balanced = false
            else:
                s.pop()
        index = index + 1

    if balanced and s.isEmpty():
        return True
    else:
        return False