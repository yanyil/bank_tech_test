class StatementPrinter
  attr_reader :history

  def initialize(account=Account.new)
    @account = account
    @history = ["date || credit || debit || balance"]
  end

  def print_out(filter=:descending)
    apply_filter(filter)
    @account.statement.each do |entry|
      add_history(entry, entry[:amount])
    end
    print @history.join("\n")
  end

  private

  def apply_filter(filter)
    @account.statement.reverse! if filter == :descending
  end

  def format_date(date)
    date.strftime("%d/%m/%Y")
  end

  def format_currency(amount)
    '%.2f' % amount
  end

  def format_amount(entry, amount)
    if entry[:amount] > 0
      "#{format_currency(entry[:amount])} ||"
    else
      "|| #{format_currency(-entry[:amount])}"
    end
  end

  def add_history(entry, amount)
    @history << "#{format_date(entry[:date])} || #{format_amount(entry, amount)} || #{format_currency(entry[:balance])}"
  end
end