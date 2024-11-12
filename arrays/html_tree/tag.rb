class Tag
  attr_accessor :name, :attrs, :children

  def initialize(name = nil, attrs = {}, children = [])
    self.name = name
    self.attrs = attrs
    self.children = children
  end

  def to_s
    "<#{name} #{attrs.map{|k,v| "#{k}=\"#{v}\""}.join(' ')}>#{children.join}</#{name}>"
  end

  def self.parse_name(string)
    name = string[1..-2]
  end

  def self.parse_attrs(string)
    attrs = {}
    string.scan(/([a-zA-Z]+)="([^" >]*)"/) do |key, value|
      attrs[key] = value
    end
    attrs
  end
end