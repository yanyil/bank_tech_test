class Account
  OVERDRAFT_LIMIT = 0

  attr_reader :balance, :statement

  def initialize
    @balance = 0
    @statement = []
  end

  def deposit(amount)
    @balance += amount
    @statement << {date: Time.now, amount: amount, balance: @balance}
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