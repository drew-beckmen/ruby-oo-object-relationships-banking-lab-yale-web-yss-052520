require 'pry'
class Transfer
  attr_reader :sender, :receiver, :amount
  attr_accessor :status
  def initialize(sender, receiver, amt)
    @sender = sender
    @receiver = receiver
    @amount = amt
    @status = "pending"
  end 

  def valid?
    self.sender.valid? && self.receiver.valid?
  end 

  def execute_transaction
    if self.status != "complete" && self.sender.balance >= self.amount && self.sender.valid? && self.receiver.valid?
      self.sender.deposit(self.amount * -1)
      self.receiver.deposit(self.amount)
      self.status = "complete"
    else 
      self.status = "rejected"
      "Transaction rejected. Please check your account balance."
    end 
  end 

  def reverse_transfer
    if self.status == "complete"
      self.sender.deposit(self.amount)
      self.receiver.deposit(self.amount * -1)
      self.status = "reversed"
    end 
  end   
end
