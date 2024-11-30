require_relative '../model/db/pg_client.rb'
require_relative '../../domain/entities/student_class.rb'
require_relative '../../domain/entities/short_student_class.rb'

class Student_list_DB
  attr_accessor :client 

  def initialize
    self.client = PG_client.new
  end

  def get_by_id(id)
    result = client.exec_params("SELECT * FROM students WHERE id = $1", [id])
    raise "Student with id=#{id} not found" if result.ntuples.zero?

    result[0] 
  end

  def get_k_n_student_short_list(k = 1, n = 20)
    k = 1 if k < 1
    offset = (k - 1) * n

    result = client.exec_params(
      "SELECT id, surname, name, second_name FROM students ORDER BY id LIMIT $1 OFFSET $2",
      [n, offset]
    )

    if result.ntuples.zero?
      raise IndexError, 'Index out of range'
    end

    student_short_list = result.map do |row|
      Short_student.from_student(Student.from_hash(row))
    end

    Data_list_student_short.new(student_short_list)
  end

  def sort(field = 'surname')
    result = client.exec("SELECT * FROM students ORDER BY #{field}")
    result.map { |row| row } 
  end

  def insert_student(student)
    client.exec_params(
      "INSERT INTO students (surname, name, second_name, birthdate, phone, telegram, email, git) VALUES ($1, $2, $3, $4, $5, $6, $7, $8)",
      [
        student.surname,
        student.name,
        student.second_name,
        student.birthdate,
        student.phone,
        student.telegram,
        student.email,
        student.git
      ]
    )
  end

  def replace_by_id(student)
    client.exec_params(
      "UPDATE students SET surname = $1, name = $2, second_name = $3, birthdate = $4, phone = $5, telegram = $6, email = $7, git = $8 WHERE id = $9",
      [
        student.surname,
        student.name,
        student.second_name,
        student.birthdate,
        student.phone,
        student.telegram,
        student.email,
        student.git,
        student.id
      ]
    )
  end

  def delete_by_id(id)
    client.exec_params("DELETE FROM students WHERE id = $1", [id])
  end

  def get_student_short_count
    result = client.exec("SELECT COUNT(*) FROM students")
    result[0]['count'].to_i
  end
end
