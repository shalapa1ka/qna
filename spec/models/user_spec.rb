# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validates' do
    it { should have_many(:answers).dependent(:destroy) }
    it { should have_many(:questions).dependent(:destroy) }
  end
end
