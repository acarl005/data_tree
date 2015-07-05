require_relative 'bin_search_tree'

tree = BinSearchTree.new
tree + 4 + 2 + 3 + 2 + 1 + 1 + 6 + 5 + 5 + 4 + 4 + 15 + 18 + 21 + 7 + 8 + 9
puts tree

tree - 6 - 3 - 15 - 18 - 21
puts tree

str_tree = BinSearchTree.new
str_tree + 'new' + 'tree' + 'for' + 'showing' + 'gem' + 'ability' + 'to' + 'print' + 'it'
str_tree + 'awesome' + 'useful' + 'bravo'
puts str_tree

