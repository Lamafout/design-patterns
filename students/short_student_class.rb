require_relative 'person_class.rb'

class Short_student < Person
  attr_reader :initials, :contact
  def initialize(id: nil, initials: nil, git: nil, contact: nil)
    super(id: id, git: git)
    @initials = initials
    @contact = contact
  end

  def self.from_student(student)
    new(id:student.id, initials: student.get_initials, git: get_git, contact: student.get_contact)
  end

  def self.from_string(id: ,string:)
    new(id: id, initials: parse_initials(string), git: parse_git(string), contact: parse_contact(string))
  end

  def to_s
    "ID: #{@id}, Initials: #{@initials}, Git: #{@git}, Contact: #{@contact}"
  end
end