require 'net/http'

class HtmlParserService
  def self.perform(url)
    begin
      uri = URI.parse(url)
      response = Net::HTTP.get_response(uri)

      if response.is_a?(Net::HTTPSuccess)
        return response.body
      else
        raise StandardError, "HTTP request to #{url} failed with code #{response.code}: #{response.message}"
      end
    rescue StandardError => e
      Rails.logger.error("Error fetching HTML from #{url}: #{e.message}")
      nil
    end
  end
end