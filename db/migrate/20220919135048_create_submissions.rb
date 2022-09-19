class CreateSubmissions < ActiveRecord::Migration[6.0]
  def change
    create_table :submissions do |t|
      t.string :subject
      t.string :title
      t.text :description
      t.datetime :deadline
      t.references :user, foreign_key:{to_table: :users}

      t.timestamps
    end
  end
end
