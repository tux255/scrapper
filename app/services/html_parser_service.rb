require 'net/http'

class HtmlParserService
  def self.perform(url)
    begin
      browser = Watir::Browser.new :chrome
      browser.goto url

      browser.html
    rescue StandardError => e
      Rails.logger.error("Error fetching HTML from #{url}: #{e.message}")
      nil
    end
  end
end

