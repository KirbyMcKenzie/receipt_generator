# frozen_string_literal: true

class InputParser
  def self.parse(file_path)
    File.readlines(file_path).map(&:strip).map do |line|
      quantity, *name_parts, _, price = line.split
      name = name_parts.join(' ')
      Item.new(name, quantity.to_i, price.to_f)
    end
  rescue Errno::ENOENT
    raise ArgumentError, "File not found: '#{file_path}'"
  end
end
