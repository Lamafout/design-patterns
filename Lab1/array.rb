def min_elem(array)
  if array.length > 0
    min = array[0]
  else min = -1
  end
  for elem in array
    min = elem if elem < min
  end
  min
end

def first_pos(array)
  result = -1
  for elem in array 
    if elem >= 0
      result = elem
      break
    end
  end
  result
end

def do_selected_method(method, path)
  file = File.new(path)
  arr = file.readlines.map(&:chomp).map(&:to_i)
  result = -1
  case method
  when 1
    result = min_elem(arr)
  when 2
    result = first_pos(arr)
  end
end

print "Выберите метод, который хотите использовать:\n1 - найти минимальный эелемент массива\n2 - найти первый пололжительный элемент\n"
method = gets.to_i
puts "Введите путь к файлу для чтения данных в массив:"
path = gets.chomp
puts "Ваш результат: #{do_selected_method(method, path)}"
