require 'rails_helper'

RSpec.describe 'Data', type: :request do
  describe 'GET /data' do
    let(:payload) {
      {
        "url": "https://some.test.com/category/product",
        "fields": {
          "price": ".some-price"
        }
      }
    }

    let(:html) {
      "<html></html>"
    }

    before do
      allow(HtmlParserService).to receive(:perform).and_return(html)
      allow(FieldsParserService).to receive(:perform).and_return({})

      get "/data", params: payload
    end

    context 'success cases' do
      context 'with meta' do
        it 'should call HtmlParserService' do
          expect(HtmlParserService).to have_received(:perform).once
        end
      end
    end

    context 'fail cases' do
      before do
        allow(HtmlParserService).to receive(:perform).and_return(html)
        allow(FieldsParserService).to receive(:perform).and_return({})

        get "/data", params: payload
      end

      context 'missing url' do
        let(:missing_payload) {
          payload.delete(:url)
        }


      end

      context 'missing fields' do
        let(:missing_payload) {
          payload.delete(:fields)
        }


      end
    end
  end
end
