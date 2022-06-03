# frozen_string_literal: true

require 'rails_helper'

describe QuestionPolicy do
  subject { described_class }
  let(:user) { create :user }
  let(:other_user) { create :user }
  let(:admin) { create :user, :admin }
  let(:question_author_user) { create :question, user: user }

  permissions :create? do
    it 'denied access to not signed in user' do
      expect(subject).not_to permit(nil, question_author_user)
    end

    it 'accepts access to signed in user' do
      expect(subject).to permit(user, question_author_user)
    end

    it 'accepts access to signed in admin' do
      expect(subject).to permit(admin, question_author_user)
    end
  end

  permissions :update?, :edit?, :destroy?, :set_best_answer? do
    it 'accepts access to owner' do
      expect(subject).to permit(user, question_author_user)
    end

    it 'accepts access to admin' do
      expect(subject).to permit(admin, question_author_user)
    end

    it 'denied access to not owner/admin' do
      expect(subject).not_to permit(other_user, question_author_user)
    end
  end
end
