require_relative 'student_class'

amal = Student.new('Blyagoz', 'Amal', 'Hazretovich', id: 1,  git: 'lamafout')
sergey = Student.new('Lotarev', 'Sergey', 'Urievuch', id: 2, phone: '88005553535')
mark = Student.new('Anikin', 'Mark', 'Andreevich', id: 3, email: 'mark.markovnik@gmail.com')
puts amal
puts sergey
puts mark
puts amal.name