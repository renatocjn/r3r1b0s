class AddRefsToRecibo < ActiveRecord::Migration
  def change
    add_reference :recibos, :usuario, index: true, foreign_key: true
    add_reference :recibos, :favorecido, index: true, foreign_key: true
    add_reference :recibos, :empresa, index: true, foreign_key: true
  end
end
