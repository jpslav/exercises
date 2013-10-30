class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.text :content, :null => false, :default => ''
      t.text :content_html, :null => false, :default => ''
      t.integer :position, :null => false
      t.integer :exercise_id, :null => false
      t.integer :credit

      t.timestamps
    end

    add_index :questions, [:exercise_id, :position], :unique => true
  end
end
