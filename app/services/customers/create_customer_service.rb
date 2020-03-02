# frozen_string_literal: true

module Services
  module Customers
    class CreateCustomerService
      def initialize(customer_params)
        @customer_params = customer_params
        find_locale customer_params.delete(:locale)
      end

      def call(&block)
        @customer = ::Customer
                    .create(@customer_params
                                    .merge({ locale: @locale }))

        if @customer.persisted?
          block.call(::Callbacks::UseCaseCallback.success(@customer))
        else
          block.call(::Callbacks::UseCaseCallback.fail(@customer.errors.full_messages.to_sentence))
        end
      end

      private

      def find_locale(name)
        @locale = ::City.find_by({ name: name })
      end
    end
  end
end
