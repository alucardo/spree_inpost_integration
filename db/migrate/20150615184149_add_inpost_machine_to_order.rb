class AddInpostMachineToOrder < ActiveRecord::Migration
  def change
    add_column :spree_orders, :inpost_machine, :string
  end
end