# frozen_string_literal: true

require_relative 'message'
module Telegram
  module Types
    # DryType class for telegram update entity
    class Update < Dry::Struct
      attribute :message, Message
      attribute :update_id, DryTypes::Coercible::Int
    end
  end
end
