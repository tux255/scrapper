require 'nokogiri'

class FieldsParserService
  def self.perform(html, fields)
    html_doc = Nokogiri::HTML(html)
    fields_found = {}

    begin
      fields_found['meta'] = fields['meta'].each_with_object({}) do |name, result|
        meta_tag = html_doc.css("meta[name='#{name}']").last
        result[name] = meta_tag['content'] if meta_tag
      end

      fields.each do |k, v|
        next if k == 'meta'

        found = html_doc.css(v)

        fields_found[k] = if found.count > 1
                            found.map { |f| f.try(:text) }
                          else
                            found.try(:text)
                          end
      end
    rescue StandardError => e
      Rails.logger.error("Error parsing HTML: #{e.message}")
      fields_found = {}
    end

    fields_found
  end
end
