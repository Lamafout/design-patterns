# вариант 2

# task 2.1: реализовать метод подсчёта количества взаимно простых чисел
def have_divider(num, begin_of_range)
  while begin_of_range != 0
    num, begin_of_range = begin_of_range, num % begin_of_range
  end
  num
end

def count_of_devidors(num)
  count = 0
  (1...num).each do |i|
    count += 1 if have_divider(num, i) == 1
  end
  count
end

puts 'Введите число для для подсчёта взаимно простых чисел:'
num = gets.to_i
puts "Количество взаимно простых чисел: #{count_of_devidors(num)}"

#task 2.2: сумма цифр числа, делящихся на 3

def sum_of_digits(num)
  sum = 0
  while num!= 0
    sum += num % 10 if num % 3 == 0
    num /= 10
  end
  sum
end

puts 'Введите число для суммы цифр, делящихся на 3:'
num = gets.to_i
puts "Сумма цифр числа, делящихся на 3: #{sum_of_digits(num)}"