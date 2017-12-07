class CreateRecibos < ActiveRecord::Migration
  def change
    create_table :recibos do |t|
      t.date :data
      t.integer :valor
      t.string :valor_extenso

      t.timestamps null: false
    end
  end
end
