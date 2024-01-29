require 'rails_helper'
require 'webmock/rspec'

RSpec.describe HtmlParserService do
  describe '.perform' do
    before do
      WebMock.disable_net_connect!(allow_localhost: true)
    end

    context 'successful cases' do
      it 'fetches HTML from a valid URL' do
        url = 'http://example.com'
        body = '<html><body>Valid HTML</body></html>'
        stub_request(:any, url).to_return(body: body)

        result = HtmlParserService.perform(url)

        expect(result).to eq(body)
      end
    end

    context 'unsuccessful cases' do
      it 'returns nil when URL is invalid or unreachable' do
        url = 'invalid_url'
        stub_request(:any, url).to_raise(SocketError)

        result = HtmlParserService.perform(url)

        expect(result).to be_nil
      end

      it 'returns nil when HTTP request returns an error status' do
        url = 'http://example.com/error'
        stub_request(:any, url).to_return(status: [500, 'Internal Server Error'])

        result = HtmlParserService.perform(url)

        expect(result).to be_nil
      end
    end
  end
end
