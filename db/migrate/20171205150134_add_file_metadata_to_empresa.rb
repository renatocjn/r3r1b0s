class AddFileMetadataToEmpresa < ActiveRecord::Migration
  def change
    add_column :empresas, :info_img_filename, :string
    add_column :empresas, :info_img_size, :integer
    add_column :empresas, :info_img_content_type, :string
  end
end
