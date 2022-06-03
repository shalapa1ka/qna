# frozen_string_literal: true

require 'support/signin_macros'
require 'support/question/new_question_macros'
require 'support/question/edit_question_macros'
require 'support/answer/new_answer_macros'
require 'support/answer/edit_answer_macros'
require 'support/answer/set_best_macros'

module AllMacros
  include SignInMacros

  # including question macros
  include NewQuestionMacros
  include EditQuestionMacros

  # including answer macros
  include NewAnswerMacros
  include EditAnswerMacros
  include BestAnswerMacros
end
