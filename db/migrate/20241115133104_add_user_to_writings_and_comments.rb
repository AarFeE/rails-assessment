class AddUserToWritingsAndComments < ActiveRecord::Migration[7.1]
  def change
    add_reference :writings, :user, null: false, foreign_key: true
    add_reference :comments, :user, null: false, foreign_key: true
  end
end
