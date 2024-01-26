require 'nokogiri'

class FieldsParserService
  def self.perform(html, fields)
    html_doc = Nokogiri::HTML(html)
    fields_found = {}

    if fields['meta'].present?
      fields_found['meta'] = {}

      fields['meta'].each { |name|
        fields_found['meta'][name] = html_doc.css("meta[name='#{name}']").last['content']
      }
    end

    fields.each do |k, v|
      next if k == 'meta'

      found = html_doc.css(v)
      fields_found[k] = found.text
    end
    
    fields_found
  end
end