class Wiki < ActiveRecord::Base
  belongs_to :user
  has_many :collaborators
  has_many :collaborators, through: :user
end
