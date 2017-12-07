class CreateUsuarios < ActiveRecord::Migration
  def change
    create_table :usuarios do |t|
      t.string :nome
      t.string :cpf
      t.string :email
      t.string :password_digest

      t.timestamps null: false
    end
  end
end
