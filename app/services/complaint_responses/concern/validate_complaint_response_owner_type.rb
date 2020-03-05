# frozen_string_literal: true

module Services
  module ComplaintResponses
    module Concern
      module ValidateComplaintResponseOwnerType
        PERMITTED_OWNER_TYPE = %w[Customer Company].freeze

        def check_permitted_owner_type
          return if @complaint_response_params[:owner_type].presence_in(PERMITTED_OWNER_TYPE)

          raise ::Exceptions::BadRequestException, ['owner type must be Customer or Company']
        end
      end
    end
  end
end
