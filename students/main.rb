require_relative 'student_class'

amal = Student.new('Blyagoz', 'Amal', 'Hazretovich', git: 'github.com/lamafout')
sergey = Student.new('Lotarev', 'Sergey', 'Urievuch', phone: '88005553535')
mark = Student.new('Anikin', 'Mark', 'Andreevich', email: 'mark.markovnik@gmail.com')
puts amal
puts sergey
puts mark