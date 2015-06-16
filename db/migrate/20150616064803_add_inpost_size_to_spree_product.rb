class AddInpostSizeToSpreeProduct < ActiveRecord::Migration
  def change
    add_column :spree_products, :inpost_size, :string
  end
end
