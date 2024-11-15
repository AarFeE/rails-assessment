class RenameTypeToGenreInWritings < ActiveRecord::Migration[7.1]
  def change
    rename_column :writings, :type, :genre
  end
end
