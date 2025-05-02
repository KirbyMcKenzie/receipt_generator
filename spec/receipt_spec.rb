# frozen_string_literal: true

require_relative '../lib/receipt'
require_relative '../lib/item'

RSpec.describe Receipt do
  describe '#initialize' do
    it 'creates a receipt with the given items' do
      items = [
        Item.new('book', 2, 12.49),
        Item.new('music CD', 1, 14.99)
      ]

      receipt = Receipt.new(items)

      expect(receipt.items).to eq(items)
    end
  end

  describe '#total_tax' do
    it 'calculates the total tax for all items' do
      items = [
        Item.new('book', 2, 12.49),        # tax: 0.00
        Item.new('music CD', 1, 14.99),    # tax: 1.50
        Item.new('chocolate bar', 1, 0.85) # tax: 0.00
      ]

      receipt = Receipt.new(items)

      expect(receipt.total_tax).to eq(1.50)
    end

    it 'calculates the total tax for imported items' do
      items = [
        Item.new('imported box of chocolates', 1, 10.00),  # tax: 0.50
        Item.new('imported bottle of perfume', 1, 47.50)   # tax: 7.15
      ]

      receipt = Receipt.new(items)

      expect(receipt.total_tax).to eq(7.65)
    end

    it 'calculates the total tax for mixed items' do
      items = [
        Item.new('imported bottle of perfume', 1, 27.99), # tax: 4.20
        Item.new('bottle of perfume', 1, 18.99),          # tax: 1.90
        Item.new('packet of headache pills', 1, 9.75),    # tax: 0.00
        Item.new('imported boxes of chocolates', 3, 11.25) # tax: 1.80
      ]

      receipt = Receipt.new(items)

      expect(receipt.total_tax).to eq(7.90)
    end
  end

  describe '#total_amount' do
    it 'calculates the total amount for all items including tax' do
      items = [
        Item.new('book', 2, 12.49),        # total: 24.98
        Item.new('music CD', 1, 14.99),    # total: 16.49
        Item.new('chocolate bar', 1, 0.85) # total: 0.85
      ]

      receipt = Receipt.new(items)

      expect(receipt.total_amount).to eq(42.32)
    end

    it 'calculates the total amount for imported items including tax' do
      items = [
        Item.new('imported box of chocolates', 1, 10.00),  # total: 10.50
        Item.new('imported bottle of perfume', 1, 47.50)   # total: 54.65
      ]

      receipt = Receipt.new(items)

      expect(receipt.total_amount).to eq(65.15)
    end

    it 'calculates the total amount for mixed items including tax' do
      items = [
        Item.new('imported bottle of perfume', 1, 27.99), # total: 32.19
        Item.new('bottle of perfume', 1, 18.99),          # total: 20.89
        Item.new('packet of headache pills', 1, 9.75),    # total: 9.75
        Item.new('imported boxes of chocolates', 3, 11.25) # total: 35.55
      ]

      receipt = Receipt.new(items)

      expect(receipt.total_amount).to eq(98.38)
    end
  end

  describe '#print' do
    it 'outputs the receipt in the expected format' do
      items = [
        Item.new('book', 2, 12.49),
        Item.new('music CD', 1, 14.99),
        Item.new('chocolate bar', 1, 0.85)
      ]

      receipt = Receipt.new(items)

      expected_output = <<~OUTPUT
        2 book: 24.98
        1 music CD: 16.49
        1 chocolate bar: 0.85
        Sales Taxes: 1.50
        Total: 42.32
      OUTPUT

      expect { receipt.print }.to output(expected_output).to_stdout
    end

    it 'handles imported items correctly' do
      items = [
        Item.new('imported box of chocolates', 1, 10.00),
        Item.new('imported bottle of perfume', 1, 47.50)
      ]

      receipt = Receipt.new(items)

      expected_output = <<~OUTPUT
        1 imported box of chocolates: 10.50
        1 imported bottle of perfume: 54.65
        Sales Taxes: 7.65
        Total: 65.15
      OUTPUT

      expect { receipt.print }.to output(expected_output).to_stdout
    end

    it 'handles a mix of imported and non-imported items' do
      items = [
        Item.new('imported bottle of perfume', 1, 27.99),
        Item.new('bottle of perfume', 1, 18.99),
        Item.new('packet of headache pills', 1, 9.75),
        Item.new('imported boxes of chocolates', 3, 11.25)
      ]

      receipt = Receipt.new(items)

      expected_output = <<~OUTPUT
        1 imported bottle of perfume: 32.19
        1 bottle of perfume: 20.89
        1 packet of headache pills: 9.75
        3 imported boxes of chocolates: 35.55
        Sales Taxes: 7.90
        Total: 98.38
      OUTPUT

      expect { receipt.print }.to output(expected_output).to_stdout
    end
  end
end
