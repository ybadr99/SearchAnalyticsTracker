# frozen_string_literal: true

# db/seeds.rb

# Create 10 dummy articles
10.times do |index|
  Article.create(
    title: "Article #{index + 1}",
    content: "This is the content of Article #{index + 1}."
  )
end
