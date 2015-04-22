class WikiPolicy < ApplicationPolicy

  def destroy?
    user.present? && (record.user == user || user.admin?)
  end

  def update?
    user.present?
  end

  def private?
    user.role == 'premium' || 'admin'
  end

  def public?
  	wiki.private = false
  end

class Scope
	attr_reader :user, :scope


	def initialize(user, scope)
		@user = user
		@scope = scope
	end

	def resolve
		wikis = []
		if user.role == 'admin'
			wikis = scope.all
		elsif 
			user.role == 'premium'
			  all_wikis = scope.all
			  all_wikis.each do |wiki|
			  	if wiki.private == false || wiki.user == user #|| wiki.user.include?(user)
			  		wikis << wiki #if the user is premium, only show them public wikis, or that private wikis they created or are collaborators on.
			  	end
			  end
		else
		wikis = Wiki.where(private: false).order('created_at DESC') 
		end
      wikis
    end
end
end