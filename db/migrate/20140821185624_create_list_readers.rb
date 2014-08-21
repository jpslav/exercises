class CreateListReaders < ActiveRecord::Migration
  def change
    create_table :list_readers do |t|
      t.references :list
      t.references :reader, polymorphic: true

      t.timestamps
    end

    add_index :list_readers, [:reader_id, :reader_type, :list_id], unique: true
    add_index :list_readers, :list_id
  end
end
