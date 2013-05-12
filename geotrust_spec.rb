require 'rspec'
require 'nokogiri'

describe Nokogiri do

  it "doesn't forget element namespaces" do
    xml = File.read('geotrust.wsdl')
    document = Nokogiri.XML(xml)

    element = document.at_xpath('//xs:schema/xs:element[@name="GetQuickApproverList"]/xs:complexType/xs:sequence/xs:element[@name="Request"]', 'xs' => 'http://www.w3.org/2001/XMLSchema')

    expect(element.namespaces).to include(
      'xmlns:quer' => 'http://api.geotrust.com/webtrust/query'
    )
  end

end
