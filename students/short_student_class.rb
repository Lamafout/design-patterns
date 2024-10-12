require_relative 'person_class.rb'

class Short_student < Person
  def initialize(id: nil, initials: nil, git: nil, contact: nil)
    super(id: id, git: git)
    @initials = initials
    @contact = contact
  end

  def self.from_student(student)
    new(id:student.id, initials: student.get_initials, git: get_git, contact: student.get_contact)
  end

  def self.from_string(id: ,string:)
    initials, git, contact = parse_info(string)
    new(id: id, initials: initials, git: git, contact: contact)
  end

  def self.parse_info(string)
    initials, git, contact = string.split(', ')
    return initials, git, contact
  end

  def to_s
    "ID: #{@id}, Initials: #{@initials}, Git: #{@git}, Contact: #{@contact}"
  end

  def get_contact
    @contact
  end
end