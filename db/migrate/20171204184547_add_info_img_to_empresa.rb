class AddInfoImgToEmpresa < ActiveRecord::Migration
  def change
    add_column :empresas, :info_img_id, :string
  end
end
