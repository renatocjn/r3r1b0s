class AddReferenteToRecibo < ActiveRecord::Migration
  def change
    add_column :recibos, :referente, :string
  end
end
