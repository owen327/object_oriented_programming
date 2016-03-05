class InvoiceEntry
  attr_accessor :quantity, :product_name

  def initialize(product_name, number_purchased)
    @quantity = number_purchased
    @product_name = product_name
  end

  def update_quantity(updated_count)
    self.quantity = updated_count if updated_count >= 0
  end
end
 # using attr_accessor we have to use self.quantity
invoice = InvoiceEntry.new("shampoo", "2")

puts invoice.quantity

invoice.update_quantity(3)

puts invoice.quantity

# This exposes the invoice.quantity=() through attr_accessor
