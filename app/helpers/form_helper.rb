module FormHelper
  def setup_addressable(addressable)
    addressable.address ||= Address.new
    addressable
  end
end