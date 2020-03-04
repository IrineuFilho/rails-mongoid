# frozen_string_literal: true

module Queries
  class ComplaintQuery
    class << self
      def call(payload = {})
        Complaint.where(query(payload))
      end

      private

      def query(payload)
        memo = {}
        payload.map { |obj| memo.merge!(map_field(obj)) }
        memo
      end

      def map_field field
        key = field.first.to_sym
        value = field.last

        case key
        when :company_id
          {'company._id': BSON::ObjectId(value)}
        when :customer_id
          {'customer._id': BSON::ObjectId(value)}
        when :locale
          {'locale.name': value}
        else
          raise ArgumentError, 'Field to filter a Complaint is invalid'
        end
      end
    end
  end
end