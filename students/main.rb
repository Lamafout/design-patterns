require_relative 'domain/entities/short_student_class'
require_relative 'core/binary_tree/binary_tree.rb'
require_relative 'data/model/data_list_student_short.rb'
require_relative 'data/sources/json_strategy.rb'
require_relative 'data/sources/yaml_strategy.rb'
require_relative 'data/sources/student_list_context.rb'
require_relative 'data/model/db/pg_client.rb'
require_relative 'data/sources/student_list_db.rb'

amal = Student.new(surname: 'Blyagoz', name: 'Amal', second_name: 'Khazretovich', git: 'github.com/lamafout', email: 'lamafout@yandex.ru', telegram: '@lamafout', birthdate: Date.new(2004, 6, 14))
sergey = Student.new(surname: 'Lotarev', name: 'Sergey', second_name: 'Urievuch', phone: '88005553535', birthdate: Date.new(2004, 10, 26))
mark = Student.new(surname: 'Anikin', name: 'Mark', second_name: 'Andreevich', email: 'mark.markovnik@gmail.com', birthdate: Date.new(2002, 10, 12))
# puts amal
# puts sergey
# puts mark
# puts amal.get_info
short_amal = Short_student.from_string(id: amal.id, string: amal.get_info)
# puts short_amal

# tree = Binary_tree.new
# tree.add(amal)
# tree.add(sergey)
# tree.add(mark)

# tree.iterator.each do |node|
#   puts node.name 
# end

