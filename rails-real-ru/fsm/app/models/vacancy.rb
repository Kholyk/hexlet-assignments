# frozen_string_literal: true

class Vacancy < ApplicationRecord
  include AASM

  validates :title, presence: true
  validates :description, presence: true

  # BEGIN
  aasm whiny_transitions: false do
    state :on_moderate, initial: true
    state :published
    state :archived

    event :publish do
      transitions from: :on_moderate, to: :published
    end

    event :archive do
      transitions from: %i[published on_moderate], to: :archived
    end
  end
  # END
end
