class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_answer, only: %i[edit update destroy]
  before_action :find_question
  before_action :check_access, only: %i[edit update destroy]

  def edit; end

  def create
    @answer = current_user.answers.build(answer_params)
    @answer.question_id = params[:question_id]

    if @answer.save
      redirect_to @question, notice: 'Answer successfully created!'
    else
      render :new
    end
  end

  def update
    if @answer.update(answer_params)
      redirect_to @question, notice: 'Answer successfully edited!'
    else
      render :edit
    end
  end

  def destroy
    redirect_to @question, notice: 'Answer successfully deleted!' if @answer.destroy
  end

  private

  def find_answer
    @answer = Answer.find(params[:id])
  end

  def find_question
    @question = Question.find(params[:question_id])
  end

  def answer_params
    params.require(:answer).permit(:body, :user_id)
  end

  def check_access
    unless current_user.admin?
      redirect_to @question, alert: "You have no right" unless @answer.user == current_user
    end
  end
end
