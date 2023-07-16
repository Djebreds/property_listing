class PropertyKindPolicy < ApplicationPolicy
  def index?
    entity.admin? || entity.marketing_officer?
  end

  def show?
    index?
  end

  def new?
    index?
  end

  def create?
    index?
  end

  def update?
    index?
  end

  def destroy?
    index?
  end
end
