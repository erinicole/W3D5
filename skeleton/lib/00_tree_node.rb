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
            node.children.each do |child|
                node_queue << child
            end
        end
        nil
    end

    def dfs(target)
        return self if self.value == target
        children.each do |child|
            result = child.dfs(target)
            return result unless result == nil
        end
        return nil
    end
end

#   1
# 2   3  <- current level, but we're checking 2 first
#4,5 6,7        <- call dfs on node 2
                    #calls dfs on node 4 & node 5

                    #dfs of the root
                #dfs of the left branch
#dfs of left branch's left branch #dfs of left branch's right branch