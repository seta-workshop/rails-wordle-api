# frozen_string_literal: true

module ActAsApiRequest
  extend ActiveSupport::Concern

  def check_format
    head :unprocessable_entity unless request.headers["content-type"] =~ /json/
  end
end
