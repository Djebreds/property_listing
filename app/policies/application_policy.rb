# frozen_string_literal: true

class ApplicationPolicy
  attr_reader :entity, :record

  def initialize(entity, record)
    @entity = entity
    @record = record
  end

  def admin?
    entity.is_a?(AdminUser)
  end

  class Scope
    def initialize(entity, scope)
      @entity = entity
      @scope = scope
    end

    def resolve
      scope.all
    end

    private

    attr_reader :entity, :scope

    def admin?
      entity.is_a?(AdminUser)
    end
  end
end
