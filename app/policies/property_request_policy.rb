class PropertyRequestPolicy < ApplicationPolicy
  def index?
    entity.admin? || entity.marketing_officer?
  end

  def show?
    index?
  end

  def new?
    entity.admin?
  end

  def create?
    new?
  end

  def update?
    new?
  end

  def destroy?
    new?
  end
end
