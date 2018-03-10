# frozen_string_literal: true

require 'dry-struct'
require 'dry-types'

module Telegram
  # wire dry-types library classes to module
  module DryTypes
    include Dry::Types.module
  end

  # Telegram::Types for parsing and OOP style processing of webhook payloads
  module Types
    require_relative 'types/update'
  end
end
