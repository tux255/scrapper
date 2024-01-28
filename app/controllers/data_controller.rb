class DataController < ApplicationController
  before_action :validate_params, only: [:perform]

  def perform
    html = HtmlParserService.perform(params[:url])
    response = FieldsParserService.perform(html, params[:fields])

    render :json => response
  end

  private

  def validate_params
    unless params[:url].present? && params[:fields].present?
      render json: { error: 'Both "url" and "fields" parameters are required' }, status: :bad_request
    end
  end
end
