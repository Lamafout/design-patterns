class Iterator include Enumerable
  attr_reader :root

  def initialize(root)
    self.root = root
  end

  def each
    enumerator = self.enumerator
    enumerator.each {|element| yield element}
  end

  private
  attr_writer :root
  def enumerator
  end
end