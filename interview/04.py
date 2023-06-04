class BankAccount:
  def __init__(self):
    self.balance = 0
    self.history = [0]
    
  def transact(self, value):

    new_balance = self.balance + value

    if new_balance >= 0:
      self.balance = new_balance
      self.history.append(self.balance)
    else:
      print("Error: cannot apply transaction on current balance!")

    return self.balance
    
  def balance_history(self):
    return self.history
