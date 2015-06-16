Deface::Override.new(:virtual_path => "spree/admin/products/_form",
    :name => "add_inpost_size_to_product_form",
    :insert_bottom => "[data-hook='admin_product_form_right']",
    :partial => "shared/inpost_size",
    :disabled => false)