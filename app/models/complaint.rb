# frozen_string_literal: true

class Complaint
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  field :description, type: String

  belongs_to :locale, class_name: '::City', foreign_key: :locale_id, inverse_of: :complaint

  belongs_to :customer, inverse_of: :complaint
  belongs_to :company, inverse_of: :complaint

  embeds_many :complaint_responses
end
