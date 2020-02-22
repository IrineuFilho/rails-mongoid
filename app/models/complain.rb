class Complain
  include Mongoid::Document
  field :title, type: String
  field :description, type: String
  field :locale, type: String
  field :company, type: String
  field :created_at, type: DateTime
  field :updated_at, type: DateTime

  belongs_to :customer, inverse_of: :complain

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
