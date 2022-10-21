# frozen_string_literal: true

class ServiceResult
  def initialize(object: nil, errors: [], messages: [])
    @object = object
    @messages = messages

    _errors(errors)
  end

  attr_reader :object, :errors, :messages

  def success?
    errors.blank?
  end

  def error
    errors.first
  end

  private

  def _errors(errors)
    @errors = errors.is_a?(Array) ? errors : [errors]
  end
end
