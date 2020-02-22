# frozen_string_literal: true

class Complain
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  field :description, type: String

  belongs_to :locale, class_name: '::City', foreign_key: :locale_id, inverse_of: :complain

  belongs_to :customer, inverse_of: :complain
  belongs_to :company, inverse_of: :complain
end
