class Person
  attr_reader :id, :git
  def initialize(id:, git:)
    self.id = id
    self.git = git
  end

  def id=(new_id)
    @id = new_id
  end

  #метод-писатель для гита и его валидатор
  def git=(new_git)
    if new_git.nil? || self.class.is_git_valid?(new_git)
      @git = new_git
    else
      raise ArgumentError, "Invalid git link"
    end
  end
  def self.is_git_valid?(git)
    return false if git.nil?
    git.match?(/^(https?:\/\/)?(www\.)?github\.com\/[a-zA-Z0-9_-]+$/)
  end

  def initials
    if @initials
      @initials
    else
      "#{@surname} #{@name[0]}.#{@second_name[0]}."
    end
  end

  def contact

  end

  #метод для быстрой проверки наличия гита и контакта у экземпляра
  def validate?
    !@git.nil? && (!@telegram.nil? || !@email.nil? || !@phone.nil? || !@contact.nil?)
  end

  def self.is_name_valid?(name)
    name.match?(/^[A-ZА-Я][a-zA-Zа-яА-Я\-]{0,49}$/)
  end
end