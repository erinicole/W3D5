require "byebug"
class PolyTreeNode
    attr_accessor :value, :children
    attr_reader :parent

    def initialize(value)
        @value = value
        @parent = nil #(another node)
        @children = []
    end

    def parent=(new_parent)
        @parent.children.delete(self) unless @parent.nil?
        @parent = new_parent 
        if new_parent != nil
            @parent.children << self
        end
    end

    def add_child(child)
        child.parent = self
    end

    def remove_child(child)
        if !self.children.include?(child)
            raise 'this node is the root'
        end
        child.parent = nil  
    end

    def bfs(target)
        node_queue = [self]
        until node_queue.empty?
            node = node_queue.shift
            return node if node.value == target
            node_queue.concat(node.children)
        end
        nil 
     end
end
