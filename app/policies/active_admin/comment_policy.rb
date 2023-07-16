# frozen_string_literal: true

module ActiveAdmin
  # Admin comment management
  class CommentPolicy < ApplicationPolicy
    def index?
      entity.admin? || entity.marketing_officer?
    end

    def show?
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
end
