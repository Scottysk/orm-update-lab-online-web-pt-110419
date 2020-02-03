require_relative "../config/environment.rb"

class Student
  
  attr_accessor :name, :grade
  attr_reader :id
  
  def initialize(id = nil, name, grade)
    @id = id
    @name = name
    @grade = grade
  end
  
  def self.create_table
    sql = <<-SQL
      CREATE TABLE IF NOT EXISTS students (
      id INTEGER PRIMARY KEY,
      name TEXT,
      album TEXT
      )
      SQL
      DB[:conn].execute(sql)
  end
  
  def self.drop_table
    sql = "DROP TABLE students"
      DB[:conn].execute(sql)
  end
  
  def save
    if !@id
      sql = <<-SQL
        INSERT INTO students (name, grade)
        VALUES (?, ?)
      SQL

      DB[:conn].execute(sql, self.name, self.grade)
      @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
    else
      sql = "UPDATE students SET name = ? WHERE id = ?"
      DB[:conn].execute(sql, @name, @id)
  end
end

  def self.create(name, grade)
    student_new = self.new(name, grade)
    student_new.save
    student_new
  end
  
  def student.new_from_db
    student_new = self.new
    
  end

  


end
