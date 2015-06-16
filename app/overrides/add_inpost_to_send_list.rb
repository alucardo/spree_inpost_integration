Deface::Override.new(:virtual_path => "spree/checkout/_delivery",
    :name => "add_inpost_to_send_list",
    :insert_after => ".list-group.shipping-methods li",
    :text => '<li class="list-group-item shipping-method">
                    <label>
                      <input type="radio" value="0" checked="checked" name="order[shipments_attributes][0][selected_shipping_rate_id]" id="order_shipments_inpost">
                      <span class="rate-name">InPost</span>
                      <span class="badge rate-cost"></span>
                    </label>
                  </li>',
    :disabled => false)