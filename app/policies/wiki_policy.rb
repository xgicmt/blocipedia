class WikiPolicy < ApplicationPolicy

  def destroy?
    user.present? && (record.user == user || user.admin?)
  end

  def update?
    edit?
  end

  def private?
    (user.role == 'premium' || 'admin') #record.user == user.shared_wikis.include?(record) || 
  end

  def public?
  	record.private = false
  end
  def edit?
    record.user == user || user.admin? || user.shared_wikis.include?(record) 
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
			#wikis = scope.paginate(page: params[:page], per_page: 10)
		elsif 
			user.role == 'premium'
			  all_wikis = scope.all
			  all_wikis.each do |wiki|
			  	if wiki.private == false || wiki.user == user || wiki.users.include?(user) #wiki.user.include?(user)
			  		wikis << wiki #if the user is premium, only show them public wikis, or that private wikis they created or are collaborators on.
			  	end
			  end
		else
			  all_wikis = scope.all
			  all_wikis.each do |wiki|
			  	if wiki.private == false || wiki.users.include?(user)
			  		wikis << wiki
			  	end
			  end
		end
		#wikis.reverse
      wikis.reverse  #.paginate(page: params[:page], per_page: 10)
    end
end
end