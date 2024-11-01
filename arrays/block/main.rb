require_relative 'processing_array_class.rb'

def from_terminal
  puts "Введите массив через пробел"
  array = gets.chomp.split(" ").map(&:to_i)
end

def from_file
  puts "Введите имя файла"
  file_name = gets.chomp
  file = File.new(file_name)
  array = file.read(file_name).split(" ").map(&:to_i)
end

def choose_source
  array = []
  puts "Выберите источник данных: 1 - из терминала, 2 - из файла"
  source = gets.chomp.to_i
  if source == 1
    array = from_terminal
  elsif source == 2
    array = from_file
  else
    puts "Неправильный выбор источника"
  end
  array
end

def main_menu
  processing_array = Processing_array.new(choose_source)
  loop do
    puts "Массив: #{processing_array.array}\n
    Выберите действие\n
    1 - найти индекс минимального элемента\n
    2 - найти количество элементов в интервале\n
    3 - найти количество элементов между минимальными\n
    4 - найти количество элементов в сегменте\n
    5 - найти уникальные элементы"
    method = gets.chomp.to_i
    case method
      when 1
        ui_index_min_elem(processing_array)
      when 2
        ui_interval(processing_array)
      when 3
        ui_count_between(processing_array)
      when 4
        ui_count_in_segment(processing_array)
      when 5
        ui_unique(processing_array)
      else 
        puts "Неправильный выбор"
      end
      puts "Для продолжения нажмите любую кнопку"
      gets
      puts "\n\n"
  end
end

def ui_index_min_elem(processing_array)
  "Индекс минимального элемента: #{processing_array.get_index_of_min}"
end

def ui_interval(processing_array)
  puts "Введите начало интервала"
  start = gets.chomp.to_i
  puts "Введите конец интервала"
  finish = gets.chomp.to_i
  "Количество элементов в интервале: #{processing_array.count_of_elems_in_range(start, finish)}"
end

def ui_count_between(processing_array)
  "Количество элементов между минимальными: #{processing_array.count_of_elems_between_mins}"
end

def ui_count_in_segment(processing_array)
  puts "Введите начало сегмента"
  start = gets.chomp.to_i
  puts "Введите конец сегмента"
  finish = gets.chomp.to_i
  "Количество элементов в сегменте: #{processing_array.count_of_elems_in_segment(start..finish)}"
end

def ui_unique(processing_array)
  puts "Уникальные элементы в объединении двух массивов: #{processing_array.unique_with_array(from_terminal)}"
end

main_menu