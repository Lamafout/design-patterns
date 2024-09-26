class Student
  #статическое поле для айди по умолчанию
  @id_counter = 0
  attr_accessor :id, :surname, :name, :second_name, :phone, :telegram, :email, :git
  def initialize(surname, name, second_name, id: self.class.increment_id, phone: nil, telegram: nil, email: nil, git: nil)
    @surname = surname
    @name = name
    @second_name = second_name
    @id = id
    self.phone = phone
    @telegram = telegram
    @email = email
    @git = git
  end

  def phone=(new_phone)
    if new_phone.nil? || self.class.is_phone_valid?(new_phone)
      @phone = new_phone
    else 
      raise ArgumentError, 'Invalid phone number'
    end
  end

  def to_s
    "ID: #{@id}, Surname: #{@surname}, Name: #{@name}, Second Name: #{@second_name}, Phone: #{@phone}, Telegram: #{@telegram}, Email: #{@email}, Git: #{@git}"
  end

  #статический метод для инкрементирования статического поля и передачи  результата в конструктор
  def self.increment_id
    @id_counter += 1
  end

  def self.is_phone_valid?(phone)
    return false if phone.nil?
    !!phone.match(/^\+?[0-9]{10,15}$/)
  end
end
