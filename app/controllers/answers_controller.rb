# frozen_string_literal: true

class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_answer, only: %i[edit update destroy]
  before_action :find_question
  before_action :authorize_answer!
  after_action :verify_authorized

  def edit; end

  def create
    @answer = current_user.answers.build(answer_params)
    @answer.question_id = params[:question_id]

    if @answer.save
      respond_to do |format|
        format.html do
          redirect_to @question, notice: 'Answer successfully created!'
        end

        format.turbo_stream { flash.now[:notice] = 'Answer successfully created!' }
      end
    else
      render :new
    end
  end

  def update
    if @answer.update(answer_params)
      respond_to do |format|
        format.html do
          redirect_to @question, notice: 'Answer successfully edited!'
        end

        format.turbo_stream { flash.now[:notice] = 'Answer successfully edited!' }
      end
    else
      render :edit
    end
  end

  def destroy
    @answer.destroy
    respond_to do |format|
      format.html do
        redirect_to @question, notice: 'Answer successfully deleted!'
      end

      format.turbo_stream { flash.now[:notice] = 'Answer successfully deleted!' }
    end
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

  def authorize_answer!
    authorize(@answer || Answer)
  end
end
