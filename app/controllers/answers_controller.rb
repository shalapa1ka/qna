# frozen_string_literal: true

class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_answer, only: %i[edit update destroy set_best]
  before_action :find_best_answer, only: :set_best
  before_action :find_question
  before_action :authorize_answer!
  after_action :verify_authorized

  def edit; end

  def create
    @answer = current_user.answers.build(answer_params)
    @answer.question_id = params[:question_id]

    if @answer.save
      respond_to do |format|
        format.html { redirect_to @question, notice: 'Answer successfully created!' }
        format.turbo_stream { flash.now[:notice] = 'Answer successfully created!' }
      end
    else
      render :new
    end
  end

  def update
    if @answer.update(answer_params)
      respond_to do |format|
        format.html { redirect_to @question, notice: 'Answer successfully edited!' }
        format.turbo_stream { flash.now[:notice] = 'Answer successfully edited!' }
      end
    else
      render :edit
    end
  end

  def set_best
    @best_answer.update(best: false)
    @answer.update(best: true)
    respond_to do |format|
      format.html { redirect_to @question, notice: 'Best answer successfully selected!' }
      format.turbo_stream { flash.now[:notice] = 'Best answer successfully selected!' }
    end
  end

  def destroy
    @answer.destroy
    respond_to do |format|
      format.html { redirect_to @question, notice: 'Answer successfully deleted!' }
      format.turbo_stream { flash.now[:notice] = 'Answer successfully deleted!' }
    end
  end

  private

  def find_answer
    @answer = Answer.find(params[:id])
  end

  def find_best_answer
    @best_answer = Answer.where(best: true)
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
