class AddNomeToEmpresa < ActiveRecord::Migration
  def change
    add_column :empresas, :nome, :string
  end
end
