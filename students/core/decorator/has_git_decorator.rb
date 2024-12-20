require_relative 'decorator'

class Has_git_decorator < Decorator
  def initialize(filter)
    puts 'hhh'
    super(filter)
  end

  def apply(decorable)
    if decorable.is_a?(Array)
      super(decorable).select { |student| !student.git.nil? }
    else 
      query = super(decorable)
      condition = query.include?("WHERE") ? "AND" : "WHERE"
      "#{query} #{condition} git IS NOT NULL"
    end
  end
end