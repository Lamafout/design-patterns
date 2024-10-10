require_relative 'person_class.rb'

class Student < Person
  def initialize(surname, name, second_name, id: nil, phone: nil, telegram: nil, email: nil, git: nil)
    @surname = surname
    @name = name
    @second_name = second_name
    super(id: id, git: git)
    set_contacts(phone: phone, telegram: telegram, email: email)
  end

  def get_info
    "#{get_initials} #{"Git: #{get_git}, " if !@git.nil?}#{get_contact if !get_contact.nil?}"
  end

  def get_initials
    "#{@surname} #{@name[0]}.#{@second_name[0]}."
  end

  def get_contact
    contacts = {'phone': @phone, 'email': @email, 'telegram': @telegram}
    contact = nil
    contacts.each do |key, value|
      if !value.nil?  
        contact = "#{key}: #{value}"
        break
      end
    end
    contact
  end

  def set_contacts(telegram: nil, email: nil, phone: nil)
    self.phone = phone if !phone.nil? #проверка на нил, чтобы не было такого, что пользователь решил изменить только один контакт, а из-за этого затёрлись другие
    self.telegram = telegram if !telegram.nil?
    self.email = email if !email.nil?
  end
  
  #ниже методы валидации строковых необязательных полей
  def self.is_phone_valid?(phone)
    return false if phone.nil?
    phone.match?(/^\+?[0-9]{10,15}$/)
  end
  
  def self.is_email_valid?(email)
    return false if email.nil?
    email.match?(/^[\w+_.-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/)
  end
  
  def self.is_telegram_valid?(telegram)
    return false if telegram.nil?
    telegram.match?(/@[a-zA-Z0-9_]{5,}$/)
  end
  
  #переопределение to_s для простого поулчения информации об экземпляре
  def to_s
    "ID: #{@id}, Surname: #{@surname}, Name: #{@name}, Second Name: #{@second_name}, #{"Phone: #{@phone}, " if !@phone.nil?}#{"Telegram: #{@telegram}, " if !@telegram.nil?}#{"Email: #{@email}, " if !@email.nil?} #{"Git: #{@git}, " if !@git.nil?}"
  end
  
  #метод для быстрой проверки наличия гита и контакта у экземпляра
  def validate?
    !@git.nil? && (!@telegram.nil? || !@email.nil? || !@phone.nil?)
  end

  #приватные методы-писатели для контактов
  private
  def phone=(new_phone)
    if new_phone.nil? || self.class.is_phone_valid?(new_phone)
      @phone = new_phone
    else 
      raise ArgumentError, 'Invalid phone number'
    end
  end

  def email=(new_email)
    if new_email.nil? || self.class.is_email_valid?(new_email)
      @email = new_email
    else
      raise ArgumentError, "Invalid email"
    end
  end
  
  def telegram=(new_telegram)
    if new_telegram.nil? || self.class.is_telegram_valid?(new_telegram)  
      @telegram = new_telegram
    else
      raise ArgumentError, "Invalid telegram"
    end
  end
end
