require "open-uri"
require "chronic"

module Motte
  class ParseError < StandardError; end

  class Parser
    def initialize(html)
      @html = html
      @attributes = {}
    end

    def self.from_url(url)
      new(open(url))
    rescue
      raise ParseError.new("Unable to fetch URL #{url}")
    end

    def parse
      load_document
      extract_attributes
      Case.new(attributes)
    end

    attr_reader :attributes

    private

    def load_document
      @doc = Nokogiri::HTML(html, nil, 'ISO-8859-1')
    rescue
      raise ParseError.new("Unable to parse HTML")
    end

    def extract_attributes
      attributes = Case.attribute_set.map { |attr| attr.name }
      attributes.each do |attr|
        self.send(:"extract_#{attr}") if self.respond_to?(:"extract_#{attr}", true)
      end
    end

    def extract_hearing_date
      span = @doc.xpath("//b/span[starts-with(., 'On ')]").first
      date = span.text.sub(/^On /, "")
      self.attributes[:hearing_date] = Chronic.parse(date).to_date
    end

    def extract_judgment_date
      date = self.attributes[:name].scan(/\(([0-9]{1,2} \w+ [0-9]{4})\)/).last.first
      self.attributes[:judgment_date] = Chronic.parse(date).to_date
    end

    def extract_court
      self.attributes[:court] = @doc.at_css("h1").text
    end

    def extract_name
      name = @doc.at_xpath("//b[contains(., 'You are here:')]/following-sibling::a[last()]/following-sibling::text()")
        .text
        .sub(/^ >>/, "")
        .gsub("\u0096", "-")
        .strip
      self.attributes[:name] = name
    end

    attr_accessor :html, :doc
    attr_writer :attributes
  end
end
