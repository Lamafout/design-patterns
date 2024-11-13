require_relative 'entities/student_class'
require_relative 'entities/short_student_class'
require_relative 'binary_tree/binary_tree.rb'

amal = Student.new('Blyagoz', 'Amal', 'Khazretovich', id: 123, git: 'github.com/lamafout', email: 'lamafout@yandex.ru', telegram: '@lamafout', birthdate: Date.new(2004, 6, 14))
sergey = Student.new('Lotarev', 'Sergey', 'Urievuch', phone: '88005553535', birthdate: Date.new(2004, 10, 26))
mark = Student.new('Anikin', 'Mark', 'Andreevich', email: 'mark.markovnik@gmail.com', birthdate: Date.new(2002, 10, 12))
puts amal
puts sergey
puts mark
puts amal.get_info
short_amal = Short_student.from_string(id: amal.id, string: amal.get_info)
puts short_amal

tree = Binary_tree.new
tree.add(amal)
tree.add(sergey)
tree.add(mark)