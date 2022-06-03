# frozen_string_literal: true

require 'rails_helper'

describe AnswerPolicy do
  subject { described_class }
  let(:question) { create :question, user: user }
  let(:user) { create :user }
  let(:other_user) { create :user }
  let(:admin) { create :user, :admin }
  let(:answer_author_user) { create :answer, user: user, question: question }

  permissions :create? do
    it 'denied access to not signed in user' do
      expect(subject).not_to permit(nil, answer_author_user)
    end

    it 'accepts access to signed in user' do
      expect(subject).to permit(user, answer_author_user)
    end

    it 'accepts access to signed in admin' do
      expect(subject).to permit(admin, answer_author_user)
    end
  end

  permissions :update?, :edit?, :destroy?, :set_best? do
    it 'accepts access to owner' do
      expect(subject).to permit(user, answer_author_user)
    end

    it 'accepts access to admin' do
      expect(subject).to permit(admin, answer_author_user)
    end

    it 'denied access to not owner/admin' do
      expect(subject).not_to permit(other_user, answer_author_user)
    end
  end
end
