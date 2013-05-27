require 'rspec'
require 'nokogiri'

describe Nokogiri do

  let(:xml) {

    Nokogiri.XML('
      <xs:schema xmlns:xs="http://www.w3.org/2001/XMLSchema">
        <xs:element xmlns:quer="http://api.geotrust.com/webtrust/query"/>
        <xs:element xmlns:quer="http://api.geotrust.com/webtrust/query"/>
      </xs:schema>
    ')

  }

  context 'with xpath' do
    it 'should not forget the quer namespace for the first element' do
      element = xml.at_xpath('//xs:element', 'xs' => 'http://www.w3.org/2001/XMLSchema')

      expect(element.namespaces).to include(
        'xmlns:quer' => 'http://api.geotrust.com/webtrust/query'
      )
    end

    it 'should not forget the quer namespace for the second element' do
      element = xml.at_xpath('//xs:element[last()]', 'xs' => 'http://www.w3.org/2001/XMLSchema')

      expect(element.namespaces).to include(
        'xmlns:quer' => 'http://api.geotrust.com/webtrust/query'
      )
    end
  end

  context 'when traversing' do
    it 'should not forget the quer namespace for the first element' do
      element = xml.root.element_children.first

      expect(element.namespaces).to include(
        'xmlns:quer' => 'http://api.geotrust.com/webtrust/query'
      )
    end

    it 'should not forget the quer namespace for the second element' do
      element = xml.root.element_children.last

      expect(element.namespaces).to include(
        'xmlns:quer' => 'http://api.geotrust.com/webtrust/query'
      )
    end
  end

end
