class Company
  include Mongoid::Document
  field :name, type: String
  field :cnpj, type: String
  field :locale, type: String
end
