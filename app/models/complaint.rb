# frozen_string_literal: true

class Complaint
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  field :description, type: String

  embeds_one :locale, class_name: '::City', inverse_of: :complaint
  embeds_one :customer, inverse_of: :complaint
  embeds_one :company, inverse_of: :complaint

  embeds_many :complaint_responses
end
