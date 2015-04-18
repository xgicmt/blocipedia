class WikiPolicy < ApplicationPolicy

def destroy?
    user.present? && (record.user == user || user.admin?)
end

def update?
	user.present?
end

end