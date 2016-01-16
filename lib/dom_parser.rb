require_relative 'tree.rb'
require_relative 'parse_tag.rb'

class DomParser
  
  attr_accessor :parse_tree

  def initialize
    @parse_tree = TagTree.new
  end

  def dom_reader(html)
    
    if File.file?(html)
       lines = File.readlines(html)
       html = lines.join.gsub("\n", " ")
    end
    build_dom_tree(html)

  end
    
  #Start method tokenize to create text and tag tokens
  def tokenize(html_string)
    
    regex = /<.*?>/
    tag_list = html_string.scan(regex)
    text_list = html_string.split(regex)
    
    #puts "Tag: #{tag_list}"
    #puts "Text: #{text_list}"

    tag_list_index  = 1
    text_list_index = 0
    tokens_array = []

    token = tag_list[0]    #Since we always start with a tag - ASSUME!
    tokens_array << token

    while tag_list_index < tag_list.size
      if text_list[text_list_index].strip.empty? 
        tokens_array << tag_list[tag_list_index]
      else
        tokens_array << text_list[text_list_index].strip 
        tokens_array << tag_list[tag_list_index].strip 
      end
      tag_list_index += 1
      text_list_index += 1
    end
    tokens_array
  end

  #End method tokenize

  def populate_tag_attributes(node,tag_attributes)
    parsed_tag = ParseTag.parse_tag tag_attributes
  
    parsed_tag.attributes.each do |name,value|
      node.attributes[name] = value
    end
         
  end

  #Start method parse_tokens_and_build_tree
  def build_dom_tree(html_string)

    tokens_array = tokenize(html_string)
    
    @parse_tree.create_node

    populate_tag_attributes(@parse_tree.root, tokens_array[0])
            
    create_dom_tree_nodes(tokens_array, @parse_tree.root)
   
    parse_tree.print_tree

  end

  #Start method create_children_for tags and text
  def create_dom_tree_nodes(tag_list,parent)
    
    return if tag_list.size < 2
          
    new_tag = tag_list[0]
    next_token_index = 1
    running_level = 1
    level_start_index = 1
    
    while next_token_index < tag_list.size
      
      if tag_list[next_token_index].strip =~ /^<[a-zA-Z0-6]+>/
        #Case for start of tag

        running_level += 1
        
        if running_level == 2

           parent.children << parse_tree.create_node
           
           populate_tag_attributes(parent.children[-1],tag_list[next_token_index])

           level_start_index = next_token_index
        end
        
      elsif tag_list[next_token_index] =~ /^<\/.*?>/
        #Case for end tag
        running_level -= 1

        if running_level == 1

          create_dom_tree_nodes tag_list[level_start_index..next_token_index],parent
          
          parent.children <<  parse_tree.create_node

          populate_tag_attributes(parent.children[-1],tag_list[next_token_index])

          level_start_index = next_token_index + 1

        end

      else

        #Case for plain text
        if running_level == 1  
           parent.children << parse_tree.create_node
           parent.children[-1].attributes["text"] = tag_list[next_token_index]
           parent.children[-1].attributes["tag"] = nil
           level_start_index = next_token_index + 1
        end 
      end
        
      next_token_index += 1
    end

  end

end

# #  html_string = '<div name="first div" id="div1_id" class="foo bar"> <h1> Some text in </h1> div text before  <section> <div><pi>    p text  </pi></div> </section> <div>    more div text  </div>  div text after</div>'

# # y = DomParser.new
# # # y.dom_reader("test.html")

# y.dom_reader(html_string)