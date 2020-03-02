# frozen_string_literal: true

class Company
  include Mongoid::Document

  field :name, type: String
  field :cnpj, type: String

  embeds_one :locale, class_name: '::City', inverse_of: :company
end
