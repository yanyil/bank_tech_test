class StatementPrinter
  attr_reader :history

  def initialize(account=Account.new)
    @account = account
    @history = ["date || credit || debit || balance"]
  end

  def print_out
    @account.statement.each do |entry|
      @history << "#{format_date(entry[:date])} || #{format_currency(entry[:amount])} || || #{format_currency(entry[:balance])}"
    end
    @history.join("\n")
  end

  private

  def format_date(date)
    date.strftime("%d/%m/%Y")
  end

  def format_currency(amount)
    '%.2f' % amount
  end
end