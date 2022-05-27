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

  describe 'GET #new' do
    before { get :new, params: { question_id: question } }

    it 'assigns a new Question to @question' do
      expect(assigns(:answer)).to be_a_new Answer
    end

    it { should render_template :new }
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
      it 're-render new view' do
        post :create, params: { answer: attributes_for(:answer, body: ''),
                                question_id: question, user_id: user }
        expect(request).to render_template :new
      end
    end
  end

  describe 'PATCH #update' do
    context 'with valid attributes' do
      it 'assings the requested question to @question' do
        patch :update, params: { id: answer, answer: attributes_for(:answer),
                                 question_id: question, user_id: user }
        expect(assigns(:answer)).to eq answer
      end
      it 'changes answer attributes' do
        patch :update, params: { id: answer, answer: attributes_for(:answer, body: 'new body'),
                                 question_id: question, user_id: user }
        answer.reload
        expect(answer.body).to eq 'new body'
      end
      it 'redirets to show view' do
        patch :update, params: { id: answer, answer: attributes_for(:answer),
                                 question_id: question, user_id: user }
        expect(request).to redirect_to question_path(assigns(:question))
      end

      context 'not owner' do
        it 'changes answer attributes' do
          sign_in other_user
          patch :update, params: { id: answer, answer: attributes_for(:answer, body: 'new body'),
                                   question_id: question, user_id: user }
          answer.reload
          expect(answer.body).to_not eq 'new body'
        end
      end

      context 'admin' do
        it 'changes answer attributes' do
          sign_in admin
          patch :update, params: { id: answer, answer: attributes_for(:answer, body: 'new body'),
                                   question_id: question, user_id: user }
          answer.reload
          expect(answer.body).to eq 'new body'
        end
      end

    end

    context 'with invalid attributes' do
      before { patch :update, params: { id: answer, answer: attributes_for(:answer, body: ''), question_id: question, user_id: user } }
      it 'not changes question attributes' do
        answer.reload
        expect(answer.body).to_not eq ''
      end

      it { should render_template :edit }
    end
  end

  describe 'DELETE #destroy' do
    before { [answer, question] }

    it 'deletes question' do
      expect do
        delete :destroy, params: { id: answer, question_id: question }
      end.to change(Answer, :count).by(-1)
    end

    it 'redirect to index view' do
      delete :destroy, params: { id: answer, question_id: question }
      expect(response).to redirect_to question_path(assigns(:question))
    end

    context 'not owner' do
      it 'deletes question' do
        sign_in other_user
        expect do
          delete :destroy, params: { id: answer, question_id: question }
        end.to_not change(Answer, :count)
      end
    end

    context 'admin' do
      it 'deletes question' do
        sign_in admin
        expect do
          delete :destroy, params: { id: answer, question_id: question }
        end.to change(Answer, :count).by(-1)
      end
    end
  end
end
