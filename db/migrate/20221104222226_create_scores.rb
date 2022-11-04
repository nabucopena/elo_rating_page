class CreateScores < ActiveRecord::Migration[7.0]
  def change
    create_table :scores do |t|
      t.string :name
      t.bigint :score
      t.integer :games
      t.timestamps
    end
  end
end
