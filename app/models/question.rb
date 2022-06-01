# frozen_string_literal: true

class Question < ApplicationRecord
  validates :title, :body, presence: true
  has_many :answers, dependent: :destroy
  belongs_to :user

  scope :ordered, -> { order('updated_at DESC') }
end
