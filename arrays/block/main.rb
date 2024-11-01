require_relative 'processing_array_class.rb'

processing_array = Processing_array.new([34, -20,  24, 90, -78, 12, -68, 11, -78, 12, 0, -9])
puts processing_array.get_index_of_min
puts processing_array.count_of_elems_in_range (-20..20)
puts processing_array.count_of_elems_between_mins
puts processing_array.count_of_elems_in_segment (-20..20)
print processing_array.unique_with_array [12, 43, -9]