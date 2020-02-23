# frozen_string_literal: true

class Customer
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :email, type: String

  has_many :complaints, inverse_of: :customer, dependent: :restrict_with_exception
end
