require_relative 'html_tree.rb'

tree = HTML_tree.new('<div class="class"><p><span>hello</span></p><p><span>hello</span></p><img class="image"/></div>')
puts 'dfs'
result = tree.dfs.filter do |element|
  element.single?
end

result.each do |element|
  puts element
end

puts "\n--------------\nbfs"
tree.bfs.each do |element|
  puts "#{element}, #{element.single?}"
end


