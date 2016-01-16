
#Should the tag regex be generic?


ParsedStringStruct = Struct.new(:attributes)

class ParseTag

  START_TAG_MATCH  = /(<[a-zA-Z1-6]+)(.*)(>)/
  END_TAG_MATCH    = /<\/[a-zA-Z1-6]+>/
  NO_END_TAG_MATCH = /<hr>|<br>/
  CLASS_MATCH      = /class='(.*?)'/
  TEXT_MATCH     = /<(^ *[^<.*>][a-zA-Z1-6]+)/
  ID_MATCH         = /id=\W(.*?)\W/
  TITLE_MATCH      = /title=\W(.*?)\W/
  NAME_MATCH       = /name=\W(.*?)\W/
  SRC_MATCH       = /src=\W(.*?)\W/
 
  def self.parse_tag(string)

    parsed_string = ParsedStringStruct.new
    parsed_string.attributes = {}

    #start of tag
    tag = string.match(START_TAG_MATCH)
    parsed_string.attributes["tag"] = tag[1]+tag[3] if tag
    #puts "tag is #{tag[1]}#{tag[3]}"

    #end of tag
    tag = string.match(END_TAG_MATCH)
    parsed_string.attributes["tag"] = tag[0] if tag

    #class
    classes = string.match(CLASS_MATCH)
    parsed_string.attributes["classes"] = classes[1] if classes

    #id
    id = string.match(ID_MATCH)
    parsed_string.attributes["id"] = id[1] if id

    #name
    name = string.match(NAME_MATCH)
    parsed_string.attributes["name"] = name[1] if name

    #title
    title = string.match(TITLE_MATCH)
    parsed_string.attributes["title"] = title[1] if title

    #src
    src = string.match(SRC_MATCH)
    parsed_string.attributes["src"] = src[1] if src

    #src
    text = string.match(TEXT_MATCH)
    parsed_string.attributes["ext"] = src[1] if src

    #puts "Parsed String is #{parsed_string}"
    return parsed_string
  end
end