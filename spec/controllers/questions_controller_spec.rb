require 'rails_helper'

describe QuestionsController do
  let(:question) { create(:question) }

  describe 'GET #index' do
    before do
      @questions = [build_stubbed(:question)]
      allow(Question).to receive(:all).and_return(@questions)
      get :index
    end

    it 'populates an array of all questions' do
      expect(assigns(:questions)).to match_array(@questions)
    end

    it { should render_template :index }
  end

  describe 'GET #show' do
    before { get :show, params: { id: question } }

    it 'assings the requested question to @question' do
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

    it 'assings the requested question to @question' do
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

  describe 'PATCH #update' do
    context 'with valid attributes' do
      it 'assings the requested question to @question' do
        patch :update, params: { id: question, question: attributes_for(:question) }
        expect(assigns(:question)).to eq question
      end

      it 'changes question attributes' do
        patch :update, params: { id: question,
                                 question: attributes_for(:question, title: 'new title', body: 'new body') }
        question.reload
        expect(question.title).to eq 'new title'
        expect(question.body).to eq 'new body'
      end

      it 'redirects to show view' do
        patch :update, params: { id: question, question: attributes_for(:question) }
        expect(request).to redirect_to question_path(assigns(:question))
      end
    end
    context 'with invalid attributes' do
      before { patch :update, params: { id: question, question: attributes_for(:question, title: '') } }
      it 'not changes question attributes' do
        question.reload
        expect(question.title).to_not eq ''
        expect(question.body).to_not eq 'Some body'
      end

      it { should render_template :edit }
    end
  end

  describe 'DELETE #destroy' do
    before { question }

    it 'deletes question' do
      expect do
        delete :destroy, params: { id: question }
      end.to change(Question, :count).by(-1)
    end

    it 'redirect to index view' do
      delete :destroy, params: { id: question }
      expect(response).to redirect_to questions_path
    end
  end
end
