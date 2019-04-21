class CreateChampions < ActiveRecord::Migration[5.2]
  def change
    create_table :champions do |t|
      t.references :list, foreign_key: true
      t.string :name
      t.string :tier
      t.integer :size

      t.timestamps
    end
  end
end
