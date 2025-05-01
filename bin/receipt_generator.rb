# frozen_string_literal: true

def parse_item(line)
  quantity, *name, _, price = line.split

  {
    quantity: quantity.to_i,
    name: name.join(' '),
    price: price.to_f
  }
end

if ARGV.empty?
  puts 'Provide input.txt file'
  exit 1
end

input_file = ARGV[0]
begin
  input_lines = File.readlines(input_file).map(&:strip)
rescue Errno::ENOENT
  puts 'File not found mate'
  exit
end

items = input_lines.map do |line|
  item_data = parse_item(line)
  puts item_data
end
