# frozen_string_literal: true

require_relative 'chat'
require_relative 'user'

module Telegram
  module Types
    # DryType class for telegram message entity
    class Message < Dry::Struct
      attribute :message_id, DryTypes::Coercible::Int
      attribute :from, User
      attribute :chat, Chat
      attribute :date, DryTypes::Date
      attribute :text, DryTypes::String
      # attribute :entities, DryTypes::Array
    end
  end
end
