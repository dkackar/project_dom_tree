
# require 'pry-byebug'

Node = Struct.new(:attributes, :children)

class TagTree

  attr_accessor :root

  def initialize( node = nil  )
    @root = node
  end
  
  def create_node
    if @root.nil?
       @root = Node.new
       current_node = @root
    else   
      current_node = Node.new
    end  
    current_node.attributes = {}
    current_node.children = []
    return current_node
  end

  def print_tree(node=@root,indent=0)

    tag_start = /<.*?>/
    tag_end = /<\/.*?>/
    
    level         = 1
    running_level = level

    attributes = node.attributes
    attribute_keys = attributes.keys

    attribute_keys.each do |this_attribute|
     
      if this_attribute == "text"
        #puts "indent is #{indent}"
        text = (attributes[this_attribute]).strip
        print "\n" + " ".rjust(indent," ")
        print "#{text}"
     
      elsif this_attribute == "tag"
       
        tag = attributes[this_attribute]
     
        if !tag.nil?
          
          if tag =~ tag_start
            if running_level == 2
              indent += 2
            end
            running_level += 1
          end

          if tag =~ tag_end
            indent -= 2
          end
          print "\n" + " ".rjust(indent," ")
          print "#{tag} "
        end
      
      else
        print "#{this_attribute} = #{attributes[this_attribute]} "
      end
    
    end
  
    children = node.children

    if children.empty?
       return indent
    end   
    
    children.each do |child|
      indent = print_tree(child,indent)
    end

  end
end

def tree_searcher(node=@root,attributes)


end