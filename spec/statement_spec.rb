require 'statement'

describe StatementPrinter do
  subject(:printer) { described_class.new(account) }
  let(:account) { double :account }
  let(:statement) { [
        {date: Time.local(2012, 1, 10), amount: 1000, balance: 1000},
        {date: Time.local(2012, 1, 13), amount: 2000, balance: 3000},
        {date: Time.local(2012, 1, 14), amount: -500, balance: 2500}
      ] }

  describe '#print_out' do
    it 'does not print out entries if there is no history' do
      allow(account).to receive(:statement).and_return []
      expect{ printer.print_out }.to output("date || credit || debit || balance").to_stdout
    end

    it 'prints out account statement details' do
      time_now = Time.local(2012, 1, 10)
      allow(account).to receive(:statement).and_return [{date: time_now, amount: 1000, balance: 1000}]
      expect{ printer.print_out }.to output("date || credit || debit || balance\n10/01/2012 || 1000.00 || || 1000.00").to_stdout
    end

    it 'can handle multiple transactions' do
      allow(account).to receive(:statement).and_return statement
      output = "date || credit || debit || balance\n14/01/2012 || || 500.00 || 2500.00\n13/01/2012 || 2000.00 || || 3000.00\n10/01/2012 || 1000.00 || || 1000.00"
      expect{ printer.print_out }.to output(output).to_stdout
    end
  end

  describe '#filter' do
    it 'defaults to output by date descending' do
      allow(account).to receive(:statement).and_return statement
      expect(printer.print_out(:descending)).to eq printer.print_out
    end

    it 'can filter output by date ascending' do
      allow(account).to receive(:statement).and_return statement
      output = "date || credit || debit || balance\n10/01/2012 || 1000.00 || || 1000.00\n13/01/2012 || 2000.00 || || 3000.00\n14/01/2012 || || 500.00 || 2500.00"
      expect{ printer.print_out(:ascending) }.to output(output).to_stdout
    end
  end
end