require "net/http"
require "uri"

Spree::CheckoutController.class_eval do

  before_action :get_zip_code
  before_action :permit_inpost_machine


  def permit_inpost_machine
    Spree::PermittedAttributes.checkout_attributes << :inpost_machine
  end


  private



  def get_zip_code
    if params[:state].present? && params[:state] == "delivery"
      @zipcode = @order.bill_address.zipcode     
    end
  end
end