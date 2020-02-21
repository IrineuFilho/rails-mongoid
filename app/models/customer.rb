class Customer
  include Mongoid::Document
  field :name, type: String
  field :email, type: String
  field :created_at, type: DateTime
  field :updated_at, type: DateTime

  has_many :complain, class_name: "Complain", inverse_of: :customer

  before_save :set_created_updated, unless: -> { self.persisted? }
  before_save :set_updated_at, if: -> { self.persisted? }

  private

  def set_created_updated
    self.created_at = self.updated_at = Time.now
  end

  def set_updated_at
    self.updated_at = Time.now
  end
end
