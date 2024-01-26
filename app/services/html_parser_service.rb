require 'net/http'

class HtmlParserService
  def self.perform(url)
    uri = URI.parse(url)
    response = Net::HTTP.get_response(uri)

    response.body
  end
end
