require_relative "array_processor.rb"

pr = Array_processor.new([12, -4, 0, 49, -97])

puts pr.all? {|elem| elem > -100}