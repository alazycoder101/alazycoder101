import time

def sumOfN(n):
    theSum = 0
    for i in range(1, n+1):
        theSum = theSum + 1
    return theSum

def sumOfN2(n):
    start = time.time()
    theSum = 0
    for i in range(1, n+1):
        theSum = theSum + 1
    end = time.time()
    return theSum, end-start

def sumOfN3(n):
    return (n*(n+1))/2
# f(n): 1, logn, n, nlogn, n2, n3, 2en

for i in range(5):
    print("Sum is %d required %10.7f seconds" % sumOfN2(10000))

