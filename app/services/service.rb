# frozen_string_literal: true

class Service
  def self.call(**args)
    new(**args).call
  rescue StandardError => e
    ServiceResult.new(errors: e.message)
  end
end
