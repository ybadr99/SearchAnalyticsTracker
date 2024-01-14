# frozen_string_literal: true

class CreateSearches < ActiveRecord::Migration[7.1]
  def change
    create_table :searches do |t|
      t.string :query
      t.string :user_ip

      t.timestamps
    end
  end
end
