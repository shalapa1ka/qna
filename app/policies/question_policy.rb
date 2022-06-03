# frozen_string_literal: true

class QuestionPolicy < ApplicationPolicy
  def create?
    user.present?
  end

  def update?
    user.admin? || user.author?(record)
  end

  def destroy?
    user.admin? || user.author?(record)
  end

  def index?
    true
  end

  def show?
    true
  end
end
