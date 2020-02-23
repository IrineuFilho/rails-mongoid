# frozen_string_literal: true

class Company
  include Mongoid::Document

  field :name, type: String
  field :cnpj, type: String

  belongs_to :city, inverse_of: :company

  has_many :complains, inverse_of: :company, dependent: :destroy

end