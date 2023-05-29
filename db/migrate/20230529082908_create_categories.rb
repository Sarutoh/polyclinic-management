# frozen_string_literal: true

class CreateCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :categories do |t|
      t.string :name, null: false, default: '', unique: true, index: true

      t.timestamps
    end

    add_column :users, :category_id, :integer
  end
end
