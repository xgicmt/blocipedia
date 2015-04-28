class Wiki < ActiveRecord::Base
  belongs_to :user
  has_many :collaborators
  has_many :users, through: :collaborators

  def slug
    title.downcase.gsub(/[!@%&"';:,.?]/, '').gsub!(/[ ]/, '-')
  end

  def to_param
    "#{id}-#{slug}"
  end
end
