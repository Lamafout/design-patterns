require_relative 'tag.rb'
require_relative 'iterators/bfs_iterator.rb'
require_relative 'iterators/dfs_iterator.rb'

class HTML_tree
  attr_reader :root

  def initialize(html)
    self.root = self.fromHTML(html)
  end
  # iterators
  
  def bfs
    BFS_iterator.new(self.root)
  end
  
  def dfs
    DFS_iterator.new(self.root)
  end
  
  private
  attr_writer :root
  
  def fromHTML(html)
    tag_stack = [] 
    html.scan(/<[^>]+>|[^<]+/) do |element| 
      element.strip!
      
      if opening_element?(element)
        processing_opening_element(element, tag_stack)
      elsif closing_element?(element)
        processing_closing_element(element, tag_stack)
      elsif single_element?(element)
        processing_single_element(element, tag_stack)
      else 
        processing_text(element, tag_stack)
      end
    end
    self.root = tag_stack.first if tag_stack.length > 0
  end

  # methods for checking type of the element
  
  def opening_element?(element)
    element[0] == '<' && (element[1].nil? ? false : element[-2]) != '/'
  end
  
  def closing_element?(element)
    element[0] == '<' && (element[1].nil? ? false : element[1]) == '/'
  end
  
  def single_element?(element)
    element[0] == '<' && (element[1].nil? ? false : element[-2]) == '/'
  end

  # methods for processing elements
  
  def processing_opening_element(element, tag_stack)
    tag_name = Tag.parse_name(element)
    tag_attrs = Tag.parse_attrs(element)
    new_tag = Tag.new(name: tag_name, attrs: tag_attrs) # creating new tag with params from element 

    if tag_stack.last
      tag_stack.last.add_child(new_tag)
    else 
      self.root = new_tag
    end

    tag_stack << new_tag
  end

  def processing_closing_element(element, tag_stack)
    if Tag.parse_name(element) == tag_stack.last.name
      tag_stack.pop
    end
  end

  def processing_single_element(element, tag_stack)
    tag_name = Tag.parse_name(element)
    tag_attrs = Tag.parse_attrs(element)
    new_tag = Tag.new(name: tag_name, attrs: tag_attrs)

    if tag_stack.last
      tag_stack.last.add_child(new_tag)
    else 
      self.root = new_tag
    end
  end

  def processing_text(element, tag_stack)
    tag_stack.last.content += element if element
  end

end