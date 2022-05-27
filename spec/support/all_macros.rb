require 'support/signin_macros'
require 'support/question/new_question_macros'
require 'support/question/edit_question_macros'
require 'support/answer/new_answer_macros_spec'
require 'support/answer/edit_answer_macros_spec'

module AllMacros
  include SignInMacros

  # including question macros
  include NewQuestionMacros
  include EditQuestionMacros

  # including answer macros
  include NewAnswerMacros
  include EditAnswerMacros
end
