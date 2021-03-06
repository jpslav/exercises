class CreateListNestings < ActiveRecord::Migration
  def change
    create_table :list_nestings do |t|
      t.references :parent_list, null: false
      t.references :child_list, null: false

      t.timestamps
    end

    add_index :list_nestings, :child_list_id, unique: true
    add_index :list_nestings, :parent_list_id
  end
end
