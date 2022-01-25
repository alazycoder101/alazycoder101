class LogicGate:
    def __init__(self, n):
        self.label = n
        self.output = None

    def getLabel(self):
        return self.label

    def getOutput(self):
        self.output = self.performGateLogic()
        return self.output


class BinaryGate(LogicGate):
    def __init__(self, n):
        super().__init__(n)

        self.pinA = None
        self.pinB = None
    
    def getPinA(self):
        return int(input("Enter Pin A input for gate " + \
            self.getLabel() + "-->"))

    def getPinB(self):
        return int(input("Enter Pin B input for gate " + \
            self.getLabel() + "-->"))


class Unarygate(LogicGate):
    def __init__(self, n):
        super().__init__(n)

        self.pin = None
    
    def getPin(self):
        return int(input("Enter Pin input for gate " + \
            self.getLabel() + "-->"))
    
class NotGate(Unarygate):
    def __init__(self, n):
        super().__init__(n)

    def performGateLogic(self):
        a = self.getPin()
        if a
          return 0
        else:
          return 1

    def setNextPin(self, source):
        if self.pin == None:
            self.pin = source
        else:
            raise RuntimeError("Error: NO EMPTY PINS")


class AndGate(BinaryGate):
    def __init__(self, n):
        super().__init__(n)
    
    def performGateLogic(self):
        a = self.getPinA()
        b = self.getPinB()

        if a==1 and b==1:
            return 1
        else:
            return 0

    def setNextPin(self, source):
        if self.pinA == None:
            self.pinA = source
        else:
            if self.pinB == None:
                self.pinB = source
            else:
                raise RuntimeError("Error: NO EMPTY PINS")


class OrGate(BinaryGate):
    def __init__(self, n):
        super().__init__(n)
    
    def performGateLogic(self):
        a = self.getPinA()
        b = self.getPinB()

        if a==1 or b==1:
            return 1
        else:
            return 0

    def setNextPin(self, source):
        if self.pinA == None:
            self.pinA = source
        else:
            if self.pinB == None:
                self.pinB = source
            else:
                raise RuntimeError("Error: NO EMPTY PINS")


class Connector:

    def __init__(self, fgate, tgate):
        self.fromgate = fgate
        self.togate = tgate

        tgate.setNextPin(self)
    
    def getFrom(self):
        return self.fromgate

    def getTo(self):
        return self.togate
    
g1 = AndGate("G1")
g2 = AndGate("G2")
g3 = OrGate("G3")
g4 = NotGate("G4")
c1 = Connector(g1, g3)
c2 = Connector(g2, g3)
c3 = Connector(g3, g4)
g4.getOutput()