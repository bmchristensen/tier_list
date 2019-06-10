class AddRoleToChampions < ActiveRecord::Migration[5.2]
  def change
    add_column :champions, :role, :string
  end
end
