# frozen_string_literal: true

require_relative '../lib/item'

if ARGV.empty?
  puts "\nNo input file provided.\nPlease pass a valid input txt file path as an argument, e.g. 'data/input_1.txt'."
  exit 1
end

input_file = ARGV[0]
begin
  input_lines = File.readlines(input_file).map(&:strip)
rescue Errno::ENOENT
  puts "\nFile not found: '#{input_file}'\nPlease ensure the path is correct and the file exists."
  exit
end

items = input_lines.map do |line|
  quantity, *name_parts, _, price = line.split
  name = name_parts.join(' ')

  Item.new(name, quantity.to_i, price.to_f)
end

items.each { |item| puts item }
total_tax = items.sum { |item| item.sales_tax * item.quantity }
total_price = items.sum(&:total_price)

puts "Sales Taxes: #{format('%.2f', total_tax)}"
puts "Total: #{format('%.2f', total_price)}"
