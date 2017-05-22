class CreateRates < ActiveRecord::Migration[5.1]
  def change
    create_table :rates do |t|
      t.integer :hourly
      t.integer :daily
      t.integer :weekly
      t.integer :monthly

      t.timestamps
    end
  end
end
