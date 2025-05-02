# frozen_string_literal: true

require_relative '../lib/item'
require_relative '../lib/input_parser'
require_relative '../lib/receipt'

if ARGV.empty?
  warn 'No input file provided. Please pass e.g. "data/input_1.txt".'
  exit 1
end

begin
  items = InputParser.parse(ARGV[0])
  Receipt.new(items).print
rescue ArgumentError => e
  warn e.message
  exit 1
end
