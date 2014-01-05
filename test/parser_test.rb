require_relative "test_helper"

describe Motte::Parser do
  before do
    data_file = File.expand_path(File.join(File.dirname(__FILE__), "..", "data", "sample.html"))
    html = File.read(data_file)
    @parser = Motte::Parser.new(html)
    @parser.parse
  end

  it "loads a document" do
    assert_kind_of Nokogiri::HTML::Document, @parser.send(:doc)
  end

  it "extracts dates" do
    assert_kind_of Date, @parser.attributes[:hearing_date]
    assert_kind_of Date, @parser.attributes[:judgment_date]
    assert_equal Date.new(2013, 10, 23), @parser.attributes[:hearing_date]
    assert_equal Date.new(2013, 12, 17), @parser.attributes[:judgment_date]
  end

  it "extracts courts" do
    assert_equal "Upper Tribunal (Immigration and Asylum Chamber)", @parser.attributes[:court]
  end

  it "extracts case names" do
    assert_equal "Gulshan (Article 8 - new Rules - correct approach) Pakistan [2013] UKUT 640 (IAC) (17 December 2013)", @parser.attributes[:name]
  end

  it "extracts citations" do

  end
end
