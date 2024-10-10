class Person
  attr_accessor :id, :git
  def initialize(id:, git:)
    @id = id
    self.git = git
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
  def get_git
    @git
  end

  def self.parse_initials(info_string)
    info_string[/^[А-Яа-яёЁA-Za-z\-]+ [А-Яа-яA-Za-z]\.[А-Яа-яA-Za-z]\./]
  end

  def self.parse_git(info_string)
    info_string[/Git: ([^,]+)/, 1]
  end

  def self.parse_contact(info_string)
    info_string[/(phone|email|telegram):\s?(\S+)/, 0]
  end
end