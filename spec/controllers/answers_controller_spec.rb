# frozen_string_literal: true

require 'rails_helper'

describe AnswersController, type: :controller do
  let(:user) { create :user }
  let(:admin) { create :user, :admin }
  let(:other_user) { create :user }
  let(:question) { create :question }
  let(:answer) { create :answer, user: user }

  before(:each) do
    @request.env['devise.mapping'] = Devise.mappings[:user]
    sign_in user
  end

  describe 'GET #edit' do
    before { get :edit, params: { id: answer, question_id: question } }
    it 'assings the requested question to @question' do
      expect(assigns(:answer)).to eq answer
    end

    it { should render_template :edit }

    context 'not owner' do
      it 'get a edit view' do
        sign_in other_user
        get :edit, params: { id: answer, question_id: question }
        expect(request).to_not render_template :edit
      end
    end

    context 'admin' do
      it 'get a edit view' do
        sign_in admin
        get :edit, params: { id: answer, question_id: question }
        expect(request).to render_template :edit
      end
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'saves the new answer in the database' do
        expect do
          post :create, params: { answer: attributes_for(:answer), question_id: question, user_id: user }
        end.to change(Answer, :count).by(1)
      end

      it 'redirects to question show view' do
        post :create, params: { id: answer, answer: attributes_for(:answer),
                                question_id: question }
        expect(request).to redirect_to(assigns(:question))
      end
    end

    context 'with invalid attributes' do
      it 'does not saves' do
        expect do
          post :create, params: { answer: attributes_for(:answer, body: ''),
                                  question_id: question, user_id: user }
        end.to_not change(Answer, :count)
      end
      it 're-render question view' do
        post :create, params: { answer: attributes_for(:answer, body: ''),
                                question_id: question, user_id: user }
        expect(request).to render_template :new
      end
    end
  end
end
