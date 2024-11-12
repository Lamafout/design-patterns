class Tag
  attr_accessor :name, :attrs, :children

  def initialize(name = nil, attrs = {}, children = [])
    self.name = name
    self.attrs = attrs
    self.children = children
  end

  def add_child(child)
    children << child
  end

  def to_s
    if ['img', 'input'].include?(self.name) # пока что ограниченное количество тегов
      "<#{name} #{attrs.map{|k,v| "#{k}=\"#{v}\""}.join(' ')} />"
    else
      "<#{name} #{attrs.map{|k,v| "#{k}=\"#{v}\""}.join(' ')}>#{children.join}</#{name}>"
    end
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