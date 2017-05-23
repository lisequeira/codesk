class ChangeTypeName < ActiveRecord::Migration[5.1]
  def change
    rename_column :spaces, :type, :type_space
  end
end
