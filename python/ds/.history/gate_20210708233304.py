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
        return int(input("Enter Pin A input for gate " + \
            self.getLabel() + "-->"))