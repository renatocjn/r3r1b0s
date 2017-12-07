class ChangeColumnOfrecibo < ActiveRecord::Migration
  def change
    change_column :recibos, :valor, :float
  end
end
