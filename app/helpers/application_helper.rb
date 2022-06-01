# frozen_string_literal: true

module ApplicationHelper
  include Pagy::Frontend

  def prepend_flash
    turbo_stream.prepend 'flash', partial: 'layouts/flash'
  end
end
