require_relative 'html_tree.rb'

tree = HTML_tree.new('<div class="box"><p>Hello, world!</p></div>')

puts tree.to_HTML
