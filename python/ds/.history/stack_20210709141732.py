class Stack:
    def __init__(self):
        self.items = []

    def isEmpty(self):
        return self.items == []
    
    def push(self, item):
        self.item.append(item)

    def pop(self):
        return self.items.pop()
    
    def peek(self):
        return self.items[len(self.items) - 1]

    def size(self):
        return len(self.items)


class Stack2:
    def __init__(self):
        self.items = []

    def isEmpty(self):
        return self.items == []
    
    def push(self, item):
        self.item.insert(0, item)

    def pop(self):
        return self.items.pop(0)
    
    def peek(self):
        return self.items[len(self.items) - 1]

    def size(self):
        return len(self.items)

