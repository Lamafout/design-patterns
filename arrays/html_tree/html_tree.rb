class HTML_tree
  attr_reader :root

  def self.fromHTML(html)
    current_parent = nil
    tag_stack = [] 

    html.scan(/<[^>]+>|[^<]+/) |element| do
      if openimg_element(element)
        #TODO: processing
      elsif closing_element(element)
        #TODO: processing
      elsif text_element?(element)
        #TODO: processing
    end
  end

  private
  attr_writer :root

  def initialize(root)
    self.root = root
  end

  def openimg_element?(element)
    element[0] == '<' && (element[1].nil? ? false : element[1]) != '/'
  end

  def closing_element?(element)
    element[0] == '<' && (element[1].nil? ? false : element[1]) == '/'
  end

  def text_element?(element)
    element[0] != '<' && (element[1].nil? ? false : element[1]) != '/'
  end

end