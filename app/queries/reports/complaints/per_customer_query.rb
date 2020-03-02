# frozen_string_literal: true

module Queries
  module Reports
    module Complaints
      class PerCustomerQuery
        class << self
          include ::Queries::Concerns::FieldValid

          VALID_FIELDS = %w(_id name).freeze

          def call(customer, field)
            raise ArgumentError, 'customer must be a Customer' unless customer.is_a? Customer
            raise ArgumentError, 'field must be _id or name' unless field_valid? field, VALID_FIELDS

            Complaint.where({"customer.#{field}": customer.send(field.to_sym)})
          end

        end
      end
    end
  end
end
