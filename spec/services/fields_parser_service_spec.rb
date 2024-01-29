require 'rails_helper'

RSpec.describe FieldsParserService do
  describe '.perform' do
    context 'successful cases' do
      let(:html) do
        <<~HTML
          <html>
            <head>
              <meta name="format-detection" content="telephone=no">
              <meta name="referrer" content="no-referrer">
            </head>
            <body>
              <h1 class="headline">Sample Headline</h1>
            </body>
          </html>
        HTML
      end
      
      let(:fields) do
        {
          'meta' => ['format-detection', 'referrer'],
          'headline' => '.headline'
        }
      end

      it 'parses fields from HTML' do
        result = FieldsParserService.perform(html, fields)

        expect(result).to include(
          'meta' => {
            'format-detection' => 'telephone=no',
            'referrer' => 'no-referrer'
          },
          'headline' => 'Sample Headline'
        )
      end
    end

    context 'unsuccessful cases' do
      it 'returns an empty hash when HTML is empty' do
        result = FieldsParserService.perform('', {})

        expect(result).to eq({})
      end

      it 'returns an empty hash when HTML has incorrect markup' do
        invalid_html = '<html><head></html>'
        result = FieldsParserService.perform(invalid_html, {})

        expect(result).to eq({})
      end
    end
  end
end
