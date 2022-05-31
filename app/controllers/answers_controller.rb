class AnswersController < ApplicationController
  before_action :find_answer, only: %i[edit update destroy]
  before_action :find_question, only: %i[new create edit update destroy]

  def new
    @answer = @question.answers.build
  end

  def edit; end

  def create
    @answer = @question.answers.build(answer_params)

    if @answer.save
      redirect_to @question, notice: 'Answer successfully created!'
    else
      render :new
    end
  end

  def update
    if @answer.update(answer_params)
      redirect_to @question
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
    params.require(:answer).permit(:body)
  end
end
