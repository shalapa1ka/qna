# frozen_string_literal: true

class QuestionsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_question, only: %i[show edit update destroy]
  before_action :authorize_question!
  after_action :verify_authorized

  def index
    @pagy, @questions = pagy Question.all
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
    @question = current_user.questions.new(question_params)

    if @question.save
      redirect_to @question, notice: 'Question successfully created!'
    else
      render :new
    end
  end

  def update
    if @question.update(question_params)
      redirect_to @question, notice: 'Question successfully edited!'
    else
      render :edit
    end
  end

  def destroy
    redirect_to questions_path, notice: 'Question successfully deleted!', status: 303 if @question.destroy
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
