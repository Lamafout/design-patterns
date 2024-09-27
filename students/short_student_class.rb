class Short_student
  def initialize(id: nil, fullname: nil, git: nil, contact: nil)
    @id = id
    @fullname = fullname
    @git = git
    @contact = contact
  end

  def self.from_student(student)
    new(id:student.id, fullname: student.get_fullname, git: student.get_git, contact: student.get_contact)
  end

  def self.from_string(id: ,string:)
    new(id: id, fullname: parse_fullname(string), git: parse_git(string), contact: parse_contact(string))
  end

  def to_s
    "ID: #{@id}, Fullname: #{@fullname}, Git: #{@git}, Contact: #{@contact}"
  end

  private
  def parse_fullname(info_string)
    info_string[/^[А-Яа-яёЁ\-]+ [А-Яа-я]\.[А-Яа-я]\./]
  end

  def parse_git(info_string)
    info_string[/Git: ([^,]+)/, 1]
  end

  def parse_contact(info_string)
    info_string[/(phone|email|telegram):\s?(\S+)/, 0]
  end
end