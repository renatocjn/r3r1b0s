class AddFileMetadataToRecibo < ActiveRecord::Migration
  def change
    add_column :recibos, :recibo_assinado_filename, :string
    add_column :recibos, :recibo_assinado_size, :integer
    add_column :recibos, :recibo_assinado_content_type, :string
  end
end
