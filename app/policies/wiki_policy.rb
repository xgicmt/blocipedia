class WikiPolicy < ApplicationPolicy

  def destroy?
    user.present? && (record.user == user || user.admin?)
  end

  def update?
    user.present?
  end

  def private?
    current_user.role == 'premium' || 'admin'
  end

end