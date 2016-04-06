require 'statement'
require 'timecop'

describe StatementPrinter do
  subject(:printer) { described_class.new(account) }
  let(:account) { double :account }

  describe '#print_out' do
    it 'does not print out entries if there is no history' do
      allow(account).to receive(:statement).and_return []
      expect(printer.print_out).to eq "date || credit || debit || balance"
    end

    it 'prints out account statement details' do
      time_now = Time.local(2012, 1, 10)
      Timecop.freeze(time_now)
      allow(account).to receive(:statement).and_return [{date: time_now, amount: 1000, balance: 1000}]
      expect(printer.print_out).to eq "date || credit || debit || balance\n10/01/2012 || 1000.00 || || 1000.00"
    end
  end
end