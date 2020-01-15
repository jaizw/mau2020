class CreateHorses < ActiveRecord::Migration[5.2]
  def change
    create_table :horses do |t|
      t.string :netkeiba_id
      t.string :name
      t.integer :sex
      t.string :sire
      t.string :broodmare_sire

      t.timestamps
    end
  end
end
