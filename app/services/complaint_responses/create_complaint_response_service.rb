module Services
  module ComplaintResponses
    class CreateComplaintResponseService
      include ::Services::ComplaintResponses::Concern::ValidateComplaintResponseOwnerType

      def initialize complaint_response_params
        @complaint_response_params = complaint_response_params
        check_permitted_owner_type
        complaint_id = complaint_response_params.delete(:complaint_id)
        @complaint = find_complaint complaint_id

      end

      def call &block
        @complaint_response = ComplaintResponse
                                  .create(@complaint_response_params
                                              .merge(complaint: @complaint))

        if @complaint_response.persisted?
          block.call(::Callbacks::UseCaseCallback.success(@complaint_response))
        else
          block.call(::Callbacks::UseCaseCallback.fail(@complaint_response.errors.full_messages.to_sentence))
        end
      end

      private

      def find_complaint complaint_id
        Complaint.find(complaint_id)
      end
    end
  end
end
