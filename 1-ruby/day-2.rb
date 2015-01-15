# Exercise 1.

arr = (1..16).to_a

(0..3).each { |i| puts arr[(i * 4)..(i * 4 + 3)].join(' ') }
arr.each_slice(4) {|i| puts i.join(' ') }

# Exercise 2.

class Tree
  attr_accessor :children, :node_name
  
  def initialize(structure={})
    if structure.size == 1 then
      singleton = structure.first
      @node_name = singleton.first
      @children = singleton.last.map { |name, children| Tree.new(name => children) }
    else
      @node_name = 'Undefined'
      @children = structure.map { |child| Tree.new(child) }      
    end
  end
  
  def visit_all(&block)
    visit &block
    children.each {|c| c.visit_all &block}
  end
  
  def visit(&block)
    block.call self
  end

  def to_s
    "#{self.node_name}#{children_string}"
  end
  
  def children_string
    children_names = children.collect {|child| child.to_s}
    " ( #{children_names.join(', ')} )" unless children.empty?
  end

end

ruby_tree = Tree.new({
  'grandpa' => {
    'dad' => {
      'child 1' => {},
      'child 2' => {},
    },
    'uncle' => {
      'child 3' => {},
      'child 4' => {},      
    },
  },
})

