class BankAccount:

    def __init__(self):
        self.balance = 0
        self.history = [0]

    def transact(self, value):
        if value > 0:
            self.balance += value
        else:
            self.balance -= value
        self.history.append(self.balance)
        return self.balance

    def balance_history(self):
        return self.history

