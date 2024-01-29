require 'rails_helper'

RSpec.describe DataController, type: :controller do
  describe 'GET #perform' do
    context 'with valid parameters' do
      let(:url) { 'http://example.com' }
      let(:fields) { { 'meta' => ['format-detection', 'referrer'], 'headline' => '.mw-headline' } }

      it 'returns a successful response' do
        stub_request(:get, url).to_return(body: '<html><body>Valid HTML</body></html>')

        get :perform, params: { url: url, fields: fields }

        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body)).to be_a(Hash)
      end
    end

    context 'with missing parameters' do
      it 'returns a bad request response' do
        get :perform

        expect(response).to have_http_status(:bad_request)
        expect(JSON.parse(response.body)).to include('error' => "Both 'url' and 'fields' parameters are required")
      end

      it 'returns a bad request response when url is missing' do
        get :perform, params: { fields: { 'meta' => ['format-detection'] } }

        expect(response).to have_http_status(:bad_request)
        expect(JSON.parse(response.body)).to include('error' => "Both 'url' and 'fields' parameters are required")
      end

      it 'returns a bad request response when fields is missing' do
        get :perform, params: { url: 'http://example.com' }

        expect(response).to have_http_status(:bad_request)
        expect(JSON.parse(response.body)).to include('error' => "Both 'url' and 'fields' parameters are required")
      end
    end
  end
end
