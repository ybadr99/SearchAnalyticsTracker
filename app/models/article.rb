class Article < ApplicationRecord
  def self.ransackable_attributes(auth_object = nil)
    %w[title]
  end
end
