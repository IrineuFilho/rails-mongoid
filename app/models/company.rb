class Company
  include Mongoid::Document
  field :name, type: String
  field :cnpj, type: String

  belongs_to :city, inverse_of: :company
end
