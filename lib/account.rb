class Account
  OVERDRAFT_LIMIT = 0

  attr_reader :balance

  def initialize
    @balance = 0
  end

  def deposit(amount)
    @balance += amount
    amount
  end

  def withdraw(amount)
    raise 'Cannot withdraw: not enough money in this account' if overdraft?(amount)
    @balance -= amount
    amount
  end

  private

  def overdraft?(amount)
    amount - @balance > OVERDRAFT_LIMIT
  end
end