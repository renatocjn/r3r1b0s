class CreateFavorecidos < ActiveRecord::Migration
  def change
    create_table :favorecidos do |t|
      t.string :rg
      t.string :cpf_cnpj

      t.timestamps null: false
    end
  end
end
