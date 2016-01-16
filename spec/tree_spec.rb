require 'dom_parser'
#require_relative 'parse_tag'
#require_relative 'tree'

describe 'DomParser' do

  let(:dom_parser) { DomParser.new }

  describe '#initialize' do
    it 'creates a Parser' do
      expect(dom_parser.class).to be_a(TagTree)
    end

  end

end
