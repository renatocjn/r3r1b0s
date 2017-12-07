class AddReciboAssinadoToRecibo < ActiveRecord::Migration
  def change
    add_column :recibos, :recibo_assinado_id, :string
  end
end
