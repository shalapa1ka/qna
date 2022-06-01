# frozen_string_literal: true

require 'rails_helper'

describe QuestionsController do
  let(:user) { create :user }
  let(:admin) { create :user, :admin }
  let(:other_user) { create :user }
  let(:question) { create :question, user: user }

  before(:each) do
    @request.env['devise.mapping'] = Devise.mappings[:user]
    sign_in user
  end

  describe 'GET #index' do
    before do
      get :index
    end

    it 'populates an array of all questions' do
      expect(assigns(:questions)).to match_array(@questions)
    end

    it { should render_template :index }
  end

  describe 'GET #show' do
    before { get :show, params: { id: question } }

    it 'assigns the requested question to @question' do
      expect(assigns(:question)).to eq question
    end

    it { should render_template :show }
  end

  describe 'GET #new' do
    before { get :new }

    it 'assigns a new Question to @question' do
      expect(assigns(:question)).to be_a_new(Question)
    end

    it { should render_template :new }
  end

  describe 'GET #edit' do
    before { get :edit, params: { id: question } }

    it 'assigns the requested question to @question' do
      expect(assigns(:question)).to eq question
    end

    it { should render_template :edit }
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'saves the new question in the database' do
        expect do
          post :create, params: { question: attributes_for(:question) }
        end.to change(Question, :count).by(1)
      end

      it 'redirects to show view' do
        post :create, params: { question: attributes_for(:question) }
        expect(response).to redirect_to question_path(assigns(:question))
      end
    end

    context 'with invalid attributes' do
      it 'does not saves the new question in the database' do
        expect do
          post :create, params: { question: attributes_for(:question, title: '') }
        end.to_not change(Question, :count)
      end

      before { post :create, params: { question: attributes_for(:question, title: '') } }
      it { should render_template :new }
    end
  end
end
