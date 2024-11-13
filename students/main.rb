require_relative 'entities/student_class'
require_relative 'entities/short_student_class'

amal = Student.new('Blyagoz', 'Amal', 'Khazretovich', id: 123, git: 'github.com/lamafout', email: 'lamafout@yandex.ru', telegram: '@lamafout')
sergey = Student.new('Lotarev', 'Sergey', 'Urievuch', phone: '88005553535')
mark = Student.new('Anikin', 'Mark', 'Andreevich', email: 'mark.markovnik@gmail.com')
puts amal
puts sergey
puts mark
puts amal.get_info
short_amal = Short_student.from_string(id: amal.id, string: amal.get_info)
puts short_amal