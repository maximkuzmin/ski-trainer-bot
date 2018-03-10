# frozen_string_literal: true

module Telegram
  module Types
    # DryType class for telegram user entity
    class User < Dry::Struct
      attribute :id, DryTypes::Coercible::Int
      attribute :is_bot, DryTypes::Form::Bool
      attribute :first_name, DryTypes::String
      attribute :last_name, DryTypes::String
      attribute :username, DryTypes::String
      attribute :language_code, DryTypes::String
    end
  end
end
