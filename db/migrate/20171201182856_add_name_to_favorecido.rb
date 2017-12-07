class AddNameToFavorecido < ActiveRecord::Migration
  def change
    add_column :favorecidos, :nome, :string
  end
end
