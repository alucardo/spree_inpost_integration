Deface::Override.new(:virtual_path => "spree/checkout/_delivery",
    :name => "add_shipment_destination",
    :insert_bottom => "#methods",
    :partial => "shared/destination",
    :disabled => false)