require 'syntax_tree'

program = SyntaxTree.parse("1 + 1")
p program.child_nodes.first.child_nodes.first
p program.construct_keys
