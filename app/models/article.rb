# frozen_string_literal: true

class Article < ApplicationRecord
  validates :title, presence: true

  def self.ransackable_attributes(_auth_object = nil)
    %w[title]
  end
end
