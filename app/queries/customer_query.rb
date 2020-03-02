# frozen_string_literal: true

module Queries
  class CustomerQuery
    class << self
      ORDER_OPTIONS = %w[name].freeze

      def call(fields, order_by: 'name', direction: 'asc')
        q = get_consult(fields)

        q.sort({ "#{order_by}": direction == 'asc' ? 1 : -1 }) if order_by.presence_in(ORDER_OPTIONS)
      end

      private

      def get_consult(fields)
        return Customer.all if fields.empty?

        Customer.and(mount_where_clause(fields))
      end

      def mount_where_clause(fields)
        q = []
        fields.each { |key, value| q << ({ "#{map_field(key.to_sym)}": /#{value}/i }) }
        q
      end

      def map_field(field)
        {
          'locale': 'locale.name',
          'name': 'name',
          'email': 'email'
        }[field]
      end
    end
  end
end
