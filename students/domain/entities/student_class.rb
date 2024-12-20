require_relative 'person_class.rb'
require 'date'

class Student < Person 
  include Comparable
  attr_reader :surname, :name, :second_name, :birthdate, :phone, :email, :telegram
  attr_accessor :unique_indicator

  def initialize(surname:, name:, second_name:, id: nil, phone: nil, telegram: nil, email: nil, git: nil, birthdate: nil, unique_indicator: :git)
    set_fullname(surname: surname, name: name, second_name: second_name)
    self.birthdate = birthdate
    super(id: id, git: git)
    set_contacts(phone: phone, telegram: telegram, email: email)
  end

  def <=>(other)
    if other.is_a?(Student)
      self.birthdate <=> other.birthdate
    else
      raise ArgumentError, "Can't compare #{self.class} with #{other.class}"
    end
  end

  def to_h
    { id: self.id, surname: self.surname, name: self.name, second_name: self.second_name, 
    birthdate: self.birthdate, telegram: self.telegram, email: self.email, phone: self.phone, git: self.git }
  end

  def self.from_hash(hash)
    self.new(**hash.transform_keys(&:to_sym))
  end

  def get_info
    "#{initials}, #{git()}, #{contact}"
  end

  def surname=(surname)
    if surname.nil? || self.class.is_name_valid?(surname)
      @surname = surname
    else 
      raise ArgumentError, "Invalid surname"
    end
  end

  def name=(name)
    if name.nil? || self.class.is_name_valid?(name)
      @name = name
    else 
      raise ArgumentError, "Invalid name"
    end
  end

  def second_name=(second_name)
    if second_name.nil? || self.class.is_name_valid?(second_name)
      @second_name = second_name
    else 
      raise ArgumentError, "Invalid second_name"
    end
  end

  def birthdate=(birthdate)
    if birthdate.is_a?(Date)
      @birthdate = birthdate
    elsif birthdate.is_a?(String) 
       @birthdate = Date.parse(birthdate)
    else
      raise ArgumentError, "Invalid birthdate"
    end
  end

  def contact
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

  def set_fullname(surname: nil, name: nil, second_name: nil)
    self.surname = surname if !surname.nil?
    self.name = name if !name.nil?
    self.second_name = second_name if !second_name.nil?
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
  
  #переопределение to_s для простого получения информации об экземпляре
  def to_s
    "ID: #{@id}, Surname: #{@surname}, Name: #{@name}, Second Name: #{@second_name}, #{"Phone: #{@phone}, " if !@phone.nil?}#{"Telegram: #{@telegram}, " if !@telegram.nil?}#{"Email: #{@email}, " if !@email.nil?} #{"Git: #{@git}, " if !@git.nil?}"
  end

  def to_h
    {
      'id' => self.id,
      'surname' => self.surname,
      'name' => self.name,
      'second_name' => self.second_name,
      'birthdate' => self.birthdate,
      'phone' => self.phone,
      'telegram' => self.telegram,
      'email' => self.email,
      'git' => self.git
    }
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
