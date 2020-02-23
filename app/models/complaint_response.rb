# frozen_string_literal: true

class ComplaintResponse
  include Mongoid::Document
  include Mongoid::Timestamps

  field :response_text, type: String
  field :owner_id, type: String
  field :owner_type, type: String

  embedded_in :complaint

  def owner
    owner_type.constantize.find({ id: owner_id })
  end

  def owner=(value)
    self.owner_id = value.id.to_s
    self.owner_type = value.class
  end
end
