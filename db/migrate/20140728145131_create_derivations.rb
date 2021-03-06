class CreateDerivations < ActiveRecord::Migration
  def change
    create_table :derivations do |t|
      t.belongs_to :derived_publication, null: false
      t.belongs_to :source_publication
      t.text :custom_attribution
      t.datetime :hidden_at

      t.timestamps
    end

    add_index :derivations, [:source_publication_id, :derived_publication_id],
              unique: true, name: "index_derivations_on_source_p_id_and_derived_p_id"
    add_index :derivations, [:derived_publication_id, :hidden_at]
  end
end
