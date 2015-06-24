require_dependency 'spree/calculator'

module Spree
  module Calculator::Shipping
    class InpostRate < ShippingCalculator
      def self.description
        "InPost"
      end

      def compute_package(package)
        @order = package.order
        get_inpost_size
        get_inpost_price
        if @c_size > 0
          @total_price = @c_size * @price_c
        elsif @b_size > 0
          @total_price = @b_size * @price_b
        else @a_size > 0
          @total_price = @a_size * @price_a
        end
        @total_price
      end

      private

      def get_inpost_price
        uri = URI.parse('http://api.paczkomaty.pl/?do=pricelist')
        response = open(uri).read.gsub("\n", "")
        hash = Hash.from_xml(response)
        @price_a = 0.0
        @price_b = 0.0
        @price_c = 0.0
        hash["paczkomaty"]["packtype"].each do |pack_type|
          if pack_type["type"] == "A"
            @price_a = pack_type["price"].to_f
          end 
          if pack_type["type"] == "B"
            @price_b = pack_type["price"].to_f
          end
          if pack_type["type"] == "C"
            @price_c = pack_type["price"].to_f
          end
        end 
      end

      def get_inpost_size
        @a_size = 0
        @b_size = 0
        @c_size = 0
        @order.line_items.each do |item|
          product = item.product
          inpost_size = product.inpost_size || "A"
          # binding.pry
          case inpost_size
          when "A"
            @a_size += (1 * item.quantity)
          when "B"
            @b_size += (1 * item.quantity)
          when "C"
            @c_size += (1 * item.quantity)
          else
            @a_size += (1 * item.quantity)
          end
        end

        if @a_size > 1 
          @b_size = @b_size + (@a_size / 2 ).to_i
          if @a_size % 2 == 1
            @b_size +=1
          end
          @a_size = 0
        elsif @a_size == 1
          if @b_size > 0 || @c_size > 0
            @b_size +=1
            @a_size = 0
          end          
        end

        if @b_size > 1 
          @c_size = @c_size + (@b_size / 2 ).to_i
          if @b_size % 2 == 1
            @c_size +=1
          end
          @b_size = 0
        elsif @b_size == 1
          if @c_size > 0
            @c_size +=1
            @b_size = 0
          end
        end
      end


    end
  end
end