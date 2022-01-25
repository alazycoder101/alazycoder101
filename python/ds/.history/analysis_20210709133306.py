def sumOfN(n):
    theSum = 0
    for i in range(1, n+1):
        theSum = theSum + 1
    return theSum
for i in range(5):
    print("Sum is %d required %10.7f seconds" % sumOfN(10000))