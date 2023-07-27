class AdminUserPolicy < ApplicationPolicy
  def index?
    entity.admin? || entity.marketing_officer?
  end

  def show?
    entity.admin?
  end

  def new?
    show?
  end

  def create?
    show?
  end

  def edit?
    show?
  end

  def update?
    show?
  end

  def destroy?
    show?
  end
end
