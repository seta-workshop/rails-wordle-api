# frozen_string_literal: true

class MatchWord < ApplicationRecord
  belongs_to :match
  belongs_to :word
end
