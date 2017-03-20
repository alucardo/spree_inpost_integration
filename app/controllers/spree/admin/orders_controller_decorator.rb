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
        m = []
        begin
          m << hash["paczkomaty"]["machine"]["town"]
          m << hash["paczkomaty"]["machine"]["street"]
          m << hash["paczkomaty"]["machine"]["buildingnumber"]
          m << hash["paczkomaty"]["machine"]["postcode"]
          m << hash["paczkomaty"]["machine"]["town"]
          m << hash["paczkomaty"]["machine"]["locationdescription"]
          @machine_info = m.join(" ")
        rescue
        end
      end
    end
  end
end
