# frozen_string_literal: true

module Services
  module Companies
    class CreateCompanyService
      def initialize(company_params)
        @company_params = company_params
        @locale = find_locale company_params.delete(:locale)
      end

      def call(&block)
        @company = Company
                   .create(
                     @company_params
                         .merge({ locale: @locale })
                   )

        if @company.persisted?
          block.call(::Callbacks::UseCaseCallback.success(@company))
        else
          block.call(::Callbacks::UseCaseCallback.fail(@company.errors.full_messages.to_sentence))
        end
      end

      private

      def find_locale(name)
        @locale = City.find_by({ name: name })
      end
    end
  end
end
