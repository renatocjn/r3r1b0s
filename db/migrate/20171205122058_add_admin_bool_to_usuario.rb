class AddAdminBoolToUsuario < ActiveRecord::Migration
  def change
    add_column :usuarios, :isAdmin, :boolean
  end
end
