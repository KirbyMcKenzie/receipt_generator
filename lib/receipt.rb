class Receipt
  attr_reader :items

  def initialize(items)
    @items = items
  end

  def total_tax
    items.sum { |item| item.sales_tax * item.quantity }
  end

  def total_amount
    items.sum { |item| item.total_price }
  end

  def print
    items.each { |item| puts item }
    puts "Sales Taxes: #{format('%.2f', total_tax)}"
    puts "Total: #{total_amount}"
  end
end
