# frozen_string_literal: true

require 'input_parser'
require 'item'
require 'tempfile'

RSpec.describe InputParser do
  describe '.parse' do
    it 'parses a file into an array of Item objects' do
      file = Tempfile.new('input')
      file.write("1 imported box of chocolates at 10.00\n2 music CDs at 14.99")
      file.rewind

      items = described_class.parse(file.path)

      expect(items.size).to eq(2)
      expect(items.first).to be_a(Item)
      expect(items.first.name).to eq('imported box of chocolates')
      expect(items.first.price).to eq(10.00)
      expect(items.first.quantity).to eq(1)

      expect(items.last.name).to eq('music CDs')
      expect(items.last.quantity).to eq(2)

      file.close
      file.unlink
    end

    it 'raises an error if file is missing' do
      expect do
        described_class.parse('nonexistent_file.txt')
      end.to raise_error(ArgumentError, /File not found/)
    end
  end
end
