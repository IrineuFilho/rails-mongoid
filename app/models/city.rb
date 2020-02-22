# frozen_string_literal: true

class City
  include Mongoid::Document
  field :name, type: String
  field :federal_unit, type: String

  has_many :companies, inverse_of: :city, dependent: :restrict_with_exception
end
