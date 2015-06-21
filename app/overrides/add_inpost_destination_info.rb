Deface::Override.new(:virtual_path => "spree/admin/orders/_shipment",
    :name => "add_inpost_destination_info",
    :insert_bottom => "table.stock-contents tbody",
    :partial => 'shared/shipment_order',
    :disabled => false)