# frozen_string_literal: true

class Customer
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :email, type: String

  embeds_one :locale, class_name: '::City', inverse_of: :customer
end
