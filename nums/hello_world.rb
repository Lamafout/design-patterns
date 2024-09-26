#task 1.1 and 1.2, нужно принять аргумент командной строки, а потом реализовать ввод с консоли
puts "Hello World, #{ARGV[0]}"
puts "Какой твой любимый ЯП?"
lang = STDIN.gets.chomp
if lang == "ruby"
  puts "Ты рубинчик"
else
  puts "Сори, но ты не рубинчик"
end

#task 1.3 пользователь вводит команды в консоли: команду ruby и команду системы. выполнить обе

print "Введите команду Ruby\n>"
command = STDIN.gets
# метод для выполенния введённой команды Ruby
eval(command)

print "Введите команду системы\n>"
command = STDIN.gets
# метод для выполенния введённой команды системы
system(command)