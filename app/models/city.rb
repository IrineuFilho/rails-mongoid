class City
  include Mongoid::Document
  field :name, type: String
  field :federal_unit, type: String

  has_many :companies, inverse_of: :city

end
