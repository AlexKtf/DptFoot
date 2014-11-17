class AddImageLinkToPlace < ActiveRecord::Migration
  def change
    add_column :places, :image_link, :string
  end
end
