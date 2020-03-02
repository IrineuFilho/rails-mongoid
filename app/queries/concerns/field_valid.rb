# frozen_string_literal: true

module Queries
  module Concerns
    module FieldValid
      def field_valid?(field, valid_fields)
        field.presence_in valid_fields
      end
    end
  end
end
