# frozen_string_literal: true

class AnswerPolicy < ApplicationPolicy
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

  def set_best?
    user.admin? || user.author?(record.question)
  end
end
