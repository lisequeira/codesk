class CreateSpaces < ActiveRecord::Migration[5.1]
  def change
    create_table :spaces do |t|
      t.references :user, foreign_key: true
      t.string :address
      t.string :city
      t.string :country
      t.text :description
      t.string :name
      t.string :type
      t.references :rate, foreign_key: true

      t.timestamps
    end
  end
end
