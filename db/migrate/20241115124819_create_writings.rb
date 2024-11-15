class CreateWritings < ActiveRecord::Migration[7.1]
  def change
    create_table :writings do |t|
      t.string :title
      t.text :content
      t.string :genre
      t.string :category

      t.timestamps
    end
  end
end
