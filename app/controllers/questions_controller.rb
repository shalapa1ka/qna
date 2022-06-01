# frozen_string_literal: true

class QuestionsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_question, only: %i[show edit update destroy]
  before_action :authorize_question!
  after_action :verify_authorized

  def index
    @pagy, @questions = pagy Question.all.ordered, link_extra: 'data-turbo-frame="pagination"'
  end

  def show
    @pagy, @answers = pagy @question.answers
    @answer = Answer.new
  end

  def new
    @question = current_user.questions.new
  end

  def edit; end

  def create
    @question = current_user.questions.build question_params

    if @question.save
      respond_to do |format|
        format.html do
          flash[:notice] = 'Question successfully created!'
          redirect_to @question
        end

        format.turbo_stream do
          flash.now[:notice] = 'Question successfully created!'
        end
      end
    else
      render :new
    end
  end

  def update
    if @question.update(question_params)
      respond_to do |format|
        format.html do
          flash[:notice] = 'Question successfully updated!'
          redirect_to @question
        end

        format.turbo_stream do
          flash.now[:notice] = 'Question successfully updated!'
        end
      end
    else
      render :edit
    end
  end

  def destroy
    @question.destroy
    respond_to do |format|
      format.html do
        flash[:notice] = 'Question successfully deleted!'
        redirect_to questions_path
      end

      format.turbo_stream { flash.now[:notice] = 'Question successfully deleted!' }
    end

  end

  private

  def find_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :body)
  end

  def authorize_question!
    authorize(@question || Question)
  end
end
