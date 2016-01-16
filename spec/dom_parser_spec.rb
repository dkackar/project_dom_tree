require 'dom_parser'
#require_relative 'parse_tag'
#require_relative 'tree'

describe 'DomParser' do

  let(:dom) {DomParser.new}

  describe '#initialize' do
    it 'creates a Parser' do
      expect(dom).to be_an_instance_of(DomParser)
    end

    it 'creates an instance of TagTree' do
      expect(dom.parse_tree).to be_an_instance_of(TagTree)
    end
  end

  describe '#dom_reader' do
    it 'should raise an ArgumentError error if no parameters passed' do
      allow(dom).to receive(:build_dom_tree).and_return true
      expect(dom.dom_reader).to raise_error(ArgumentError)
    end

    it 'should not raise an error if some string is passed' do
      allow(dom).to receive(:build_dom_tree).and_return true
      expect(dom.dom_reader("string")).to eq true 
    end

    it 'should not raise an error if valid file is passed' do
      allow(dom).to receive(:build_dom_tree).and_return true
      expect(dom.dom_reader("test.html")).to eq true 
    end
  end

  describe '#tokenize' do
    it 'should tokenize when a simple html string with text and html tags is passed' do
      array = dom.tokenize("<html> <div> text </div> </html>")
      expect(array).to be_a(Array)

      array = dom.tokenize("<html> <div> text </div> </html>")
      array = array.join.gsub("\n","")
      expect(array).to be_eq "<html><div></div>text</html>"

    end

    it 'should tokenize when a simple html string with without text is passed' do
      array = dom.tokenize("<html> <div> </div> </html>")
      expect(array).to be_a(Array)
    end
  end
end
