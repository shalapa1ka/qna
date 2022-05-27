class QuestionsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_question, only: %i[show edit update destroy]
  before_action :check_access, only: %i[edit update destroy]

  def index
    @pagy, @questions = pagy Question.all
  end

  def show
    @pagy, @answers = pagy @question.answers
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
    redirect_to questions_path, notice: 'Question successfully deleted!' if @question.destroy
  end

  private

  def find_question
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :body)
  end

  def check_access
    unless current_user.admin?
      redirect_to root_path, alert: "You have no right" unless @question.user == current_user
    end
  end
end
