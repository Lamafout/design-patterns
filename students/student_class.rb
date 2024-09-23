class Student
  def initialize(surname, name, second_name, id = 1, phone='', telegram='', email='', git='')
    @surname = surname
    @name = name
    @second_name = second_name
    @id = id
    @phone = phone
    @telegram = telegram
    @email = email
    @git = git
  end
  #TODO заменить на аттибуты
  def id
    @id
  end

  def surname
    @surname
  end
  def name
    @name
  end
  def second_name
    @second_name
  end
  def phone
    @phone
  end
  def telegram
    @telegram
  end
  def email
    @email
  end
  def git
    @git
  end

  def id=(id)
    @id = id
  end

  def surname=(surname)
    @surname = surname
  end
  def name=(name)
    @name = name
  end
  def second_name=(second_name)
    @second_name = second_name
  end
  def phone=(phone)
    @phone = phone
  end
  def telegram=(telegram)
    @telegram = telegram
  end
  def email=(email)
    @email = email
  end
  def git=(git)
    @git = git
  end

end
