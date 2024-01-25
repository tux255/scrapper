require 'nokogiri'

class FieldsParserService
  def self.perform(html, fields)
    html_doc = Nokogiri::HTML(html)
    
    fields_found = {}

    fields.each do |k,v| 
      found = html_doc.css(v)

      fields_found[k] = found.text
    end

    fields_found
  end
end