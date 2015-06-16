Spree::CheckoutController.class_eval do

  before_action :get_inpost_cast, only: [:edit]

  private

  def get_inpost_cast
    @zipcode = @order.bill_address.zipcode
    # binding.pry
  end
end