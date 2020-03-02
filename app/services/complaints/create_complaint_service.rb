# frozen_string_literal: true

module Services
  module Complaints
    class CreateComplaintService
      def initialize(complaint_params)
        @complaint_params = complaint_params
        find_customer complaint_params.delete(:customer_id)
        find_company complaint_params.delete(:company_id)
        find_locale @customer.locale.name
      end

      def call(&block)
        @complaint = ::Complaint
                     .create(@complaint_params
                                     .merge({ customer: @customer,
                                              company: @company,
                                              locale: @city }))

        if @complaint.persisted?
          block.call(::Callbacks::UseCaseCallback.success(@complaint))
        else
          block.call(::Callbacks::UseCaseCallback.fail(@complaint.errors.full_messages.to_sentence))
        end
      end

      private

      def find_customer(customer_id)
        @customer = ::Customer.find_by({ id: customer_id })
      end

      def find_company(company_id)
        @company = ::Company.find_by({ id: company_id })
      end

      def find_locale(locale)
        @city = ::City.find_by({ name: locale })
      end
    end
  end
end
