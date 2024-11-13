require_relative 'node.rb'

class Binary_tree include Enumerable
  attr_accessor :root

  def initialize
    self.root = nil
  end

  def add(value)
    new_node = Node.new(value: value)
    if self.root.nil?
      self.root = new_node
    else
      self.root.insert(self.root, new_node)
    end
  end

  private

  def insert(root, node)
    return node if root.nil?

    if node.value < root.value
      insert(root.left, node)
      root.left.parent = root
    else 
      insert(root.right, node)
      root.right.parent = root
    end
  end

end