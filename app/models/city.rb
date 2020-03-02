# frozen_string_literal: true

class City
  include Mongoid::Document
  field :name, type: String
  field :federal_unit, type: String
end
