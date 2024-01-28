require 'net/http'

class HtmlParserService
  def self.perform(url)
    begin
      uri = URI.parse(url)
      response = Net::HTTP.get_response(uri)
  
      response.body
    rescue StandardError => e
      Rails.logger.error("Error fetching HTML from #{url}: #{e.message}")
      nil
    end
  end
end

