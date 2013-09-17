class CreateExercises < ActiveRecord::Migration
  def change
    create_table :exercises do |t|
      t.text :content, :null => false, :default => ''
      t.text :content_html, :null => false, :default => ''
      t.integer :number, :null => false
      t.integer :version, :null => false, :default => 1
      t.datetime :published_at
      t.integer :license_id, :null => false
      t.integer :credit
      t.integer :embargo_days, :null => false, :default => 0
      t.date :embargoed_until
      t.boolean :only_embargo_solutions, :null => false, :default => false
      t.integer :locked_by
      t.datetime :locked_at

      t.timestamps
    end

    add_index :exercises, [:number, :version], :unique => true
    add_index :exercises, :published_at
    add_index :exercises, :license_id
  end
end
