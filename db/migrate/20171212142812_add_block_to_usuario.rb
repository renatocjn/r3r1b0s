class AddBlockToUsuario < ActiveRecord::Migration
  def change
    add_column :usuarios, :isBlocked, :boolean
  end
end
