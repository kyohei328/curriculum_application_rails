class TaxonomyPolicy < ApplicationPolicy
  def index?
    # true
    user.admin? || user.editor?
  end

  def create?
    user.admin? || user.editor?
  end

  def update?
    # true
    user.admin? || user.editor?
  end

  def destroy?
    # true
    user.admin? || user.editor?
  end
end
