# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  has_many :answers, dependent: :destroy
  has_many :questions, dependent: :destroy

  def author?(obj)
    obj.user == self
  end
end
