Spree::Admin::OrdersController.class_eval do

  before_action :get_inpost_info

  private

  def get_inpost_info
    if @order
      @inpost_machine = @order.inpost_machine
      if @inpost_machine.present?
        uri = URI.parse('http://api.paczkomaty.pl/?do=findmachinebyname&name=' + @inpost_machine)
        response = open(uri).read.gsub("\n", "")
        hash = Hash.from_xml(response)
        @machine_info = hash["paczkomaty"]["machine"]["town"] + " " + hash["paczkomaty"]["machine"]["street"] + " " + hash["paczkomaty"]["machine"]["buildingnumber"] + " " + hash["paczkomaty"]["machine"]["postcode"] + " " + hash["paczkomaty"]["machine"]["town"] + ". " + hash["paczkomaty"]["machine"]["locationdescription"]
      end
    end
  end
end