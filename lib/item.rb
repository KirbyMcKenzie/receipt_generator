# frozen_string_literal: true

class Item
  attr_reader :name, :quantity, :price, :imported

  BASIC_TAX = 0.10
  IMPORT_DUTY = 0.05

  def initialize(name, quantity, price)
    @name = name
    @quantity = quantity
    @price = price
  end

  def imported?
    name.include?('imported')
  end

  def exempt?
    name.match?(/book|chocolate|pill/i)
  end

  def sales_tax
    rate = 0
    rate += BASIC_TAX unless exempt?
    rate += IMPORT_DUTY if imported?
    round_up(price * rate)
  end

  def total_price
    (price + sales_tax) * quantity
  end

  def to_s
    "#{quantity} #{name}: #{format('%.2f', total_price)}"
  end

  private

  def round_up(amount)
    (amount * 20).ceil / 20.0
  end
end
