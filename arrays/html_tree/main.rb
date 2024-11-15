require_relative 'html_tree.rb'

tree = HTML_tree.new('<div class="class"><p><span>hello</span></p><p><span>hello</span></p></div>')
puts 'dfs'
tree.dfs.each do |element|
  puts "#{element}"
end

puts "\n--------------\nbfs"
tree.bfs.each do |element|
  puts "#{element}"
end
