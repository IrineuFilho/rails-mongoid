module Services
  module ComplaintResponses
    class UpdateComplaintResponseService
      include ::Services::ComplaintResponses::Concern::ValidateComplaintResponseOwnerType

      def initialize complaint_response_params
        @complaint_response_params = complaint_response_params
        check_permitted_owner_type
        complaint_id = complaint_response_params.delete(:complaint_id)
        @complaint = find_complaint complaint_id
        complaint_response_id = complaint_response_params.delete(:id)
        @complaint_response = find_complaint_response @complaint, complaint_response_id
      end

      def call &block
        if @complaint_response.update(@complaint_response_params)
          block.call(::Callbacks::UseCaseCallback.success(@complaint_response))
        else
          block.call(::Callbacks::UseCaseCallback.fail(@complaint_response.errors.full_messages.to_sentence))
        end
      end

      private

      def find_complaint complaint_id
        Complaint.find(complaint_id)
      end

      def find_complaint_response complaint, id
        complaint.complaint_responses.find(id)
      end

    end
  end
end
