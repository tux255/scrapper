# require_relative '../services/html_parser_service'

class DataController < ApplicationController
  def perform
    html = HtmlParserService.perform(data_params[:url])
    response = FieldsParserService.perform(html, data_params[:fields])

    render :json => response
  end

  private

  def data_params
    # TODO: Do I need require here > params.require(:fields) or permit should be?
    params.permit(:url, fields: {}).to_h
  end
end
