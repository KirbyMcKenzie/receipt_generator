# frozen_string_literal: true

require 'item'

RSpec.describe Item do
  describe '#imported?' do
    it 'returns true if the item is imported' do
      item = Item.new('imported chocolate', 1, 10.0)
      expect(item.imported?).to be true
    end

    it 'returns false if the item is not imported' do
      item = Item.new('chocolate', 1, 10.0)
      expect(item.imported?).to be false
    end
  end

  describe '#sales_tax' do
    it 'returns 0.00 for exempt and not imported item (e.g. book)' do
      item = Item.new('book', 1, 12.99)
      expect(item.sales_tax).to eq(0.00)
    end

    it 'returns 0.50 for exempt and imported item (e.g. imported chocolate)' do
      item = Item.new('imported chocolate', 1, 10.00)
      expect(item.sales_tax).to eq(0.50) # 5% of 10.00
    end

    it 'returns 1.50 for non-exempt and not imported item (e.g. music CD)' do
      item = Item.new('music CD', 1, 14.99)
      expect(item.sales_tax).to eq(1.50) # 10% of 14.99 rounded up
    end

    it 'returns 2.00 for non-exempt and imported item (e.g. imported music CD)' do
      item = Item.new('imported music CD', 1, 14.99)
      expect(item.sales_tax).to eq(2.25) # 15% of 14.99 rounded up
    end
  end
end
