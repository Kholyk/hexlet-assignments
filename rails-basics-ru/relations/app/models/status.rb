# frozen_string_literal: true

class Status < ApplicationRecord
  # BEGIN
  belongs_to :task
  # END
end
