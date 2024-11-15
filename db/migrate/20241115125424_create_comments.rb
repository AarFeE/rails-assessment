class CreateComments < ActiveRecord::Migration[7.1]
  def change
    create_table :comments do |t|
      t.string :content
      t.boolean :review
      t.references :writing, null: false, foreign_key: true

      t.timestamps
    end
  end
end
