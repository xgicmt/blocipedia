class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :wikis
  has_many :collaborators
  has_many :shared_wikis, through: :collaborators, source: :wikis
  

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

         after_initialize :init
         
         def init
         	self.role ||= 'standard'
         end

         def admin?
         	role == 'admin'
         end

         def premium?
         	role == 'premium'
         end

         def standard?
         	role == 'standard'
         end

end
