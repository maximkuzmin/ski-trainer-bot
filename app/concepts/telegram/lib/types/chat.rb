# frozen_string_literal: true

module Telegram
  module Types
    # DryType class for telegram chat entity
    class Chat < Dry::Struct
      attribute :id, DryTypes::Coercible::Int
      attribute :first_name, DryTypes::String
      attribute :last_name, DryTypes::String
      attribute :username, DryTypes::String
      attribute :type, DryTypes::String
    end
  end
end
