require_relative 'parse_tag'

Tag = Struct.new(:type, :classes, :id, :name, :src, :title, :text, :children, :parent)
# :attributes that holds all html elements
# Tag class
# methods on tag class to retrieve that attribute

class ParseTree
	attr_accessor :html_code, :root, :tag_type

  def initialize(html_code)
  	regex = /<.*?>/
    @tag_type = html_string.scan(regex)
    regex = />(.*?)</
    @text_list = html_string.scan(regex)
    @text_list.each do |text|
      text.each do |text_item|
      text_item.strip!
      end
    end
    # @parse = ParseTag.new(html_code)
    @root = nil
  end

  def add_root_node(first_tag)
    @root = Tag.new(first_tag)
  end

  def add_node(new_node)
    new_node = Tag.new()
  end

  def add_child_node(new_node, parent)
  end

  def make_tree
    #if we don't have a root, make one
    unless @root
      add_root_node(@tag_type[0]) #first open tag
    end

    current_node = @root
    
    #for each element of the tag_type array check if it has a /
    #if element has no /, go to text_list and get child
    #make a child node
    #if element has a /, make node
    @tag_type.each do |tag|
      regex = /<\//
      if !tag.match(regex)
       add_node(tag)
      elsif 
        add_child_node()#create child node 
        text_list_index += 1
      end

    while @html_code.length > 0
      add_node(???????????)
    end
  end

#tag_type
#["<div>", "<p>", "</p>", "<div>", "</div>", "</div>"] 

#text_list
#[["div text before"], ["p text"], [""], ["more div text"], ["div text after"]] 

  # def add_node()
		# if current node is nil
		# 	new structures
		# else
		# 	add_node (data)

  # end
end

html_string = "<div>  div text before  <p>    p text  </p>  <div>    more div text  </div>  div text after</div>"

tree = ParseTree.new(html_string)
tree.make_tree

 regex = /<.*?>/
p html_string.scan(/<.*?>/)
p html_string.scan(/>(.*?)</)

