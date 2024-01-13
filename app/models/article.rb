class Article < ApplicationRecord
  def self.ransackable_attributes(_auth_object = nil)
    %w[title]
  end
end
