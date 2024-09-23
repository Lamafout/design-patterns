class Student
  def initialize(surname, name, second_name, id = nil, phone=nil, telegram=nil, email=nil, git=nil)
    @surname = surname
    @name = name
    @second_name = second_name
    @id = id
    @phone = phone
    @telegram = telegram
    @email = email
    @git = git
  end

  def to_s
    #get info about student in ine string and return it
    "ID: #{@id}, Surname: #{@surname}, Name: #{@name}, Second Name: #{@second_name}, Phone: #{@phone}, Telegram: #{@telegram}, Email: #{@email}, Git: #{@git}"
  end
  attr_accessor :id, :surname, :name, :second_name, :phone, :telegram, :email, :git
end
