class CreateTrueOrFalseAnswers < ActiveRecord::Migration
  def change
    create_table :true_or_false_answers do |t|
      t.text :content, :null => false, :default => ''
      t.text :content_html, :null => false, :default => ''
      t.integer :position, :null => false
      t.integer :question_id, :null => false
      t.boolean :is_true, :null => false, :default => false
      t.integer :credit

      t.timestamps
    end

    add_index :true_or_false_answers, [:question_id, :position], :unique => true
  end
end
