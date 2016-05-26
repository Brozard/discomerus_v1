# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


Buyer.create(company_name: "Test Company", agent_name: "Brian Nickerson", email: "eatgamecode@gmail.com", password: "abcd1234")
Buyer.create(company_name: "Testing Industries", agent_name: "Jaime Garcia", email: "jaimiho@gmail.com", password: "1234")

categories = []
10.times do
  categories << Faker::Commerce.department(1)
end
categories.uniq!
categories.each do |cat|
  Category.create(category_name: cat)
end

10.times do |n|
  te = TradeEvent.new(event_name: Faker::App.name, start_date: (Date.new(2016,3,28) + (7 * n)), end_date: (Date.new(2016,3,31) + (7 * n)), buyer_id: ((n % 2) + 1))
  te.address = Address.new(street_address_1: Faker::Address.street_address, city: Faker::Address.city, state: Faker::Address.state_abbr, country: Faker::Address.country, postal_code: Faker::Address.postcode)
  te.save
end

10.times do |i|
  10.times do |j|
    fn = Faker::Name.first_name
    ln = Faker::Name.last_name
    m = Manufacturer.new(company_name: Faker::Company.name, shipping_port: Faker::Address.city, contact_name: "#{fn} #{ln}", email: Faker::Internet.email(fn), phone_number: (Random.rand(5550000000..5559999999)).to_s)
    m.address = Address.new(street_address_1: Faker::Address.street_address, city: Faker::Address.city, state: Faker::Address.state_abbr, country: Faker::Address.country, postal_code: Faker::Address.postcode)
    m.save
    10.times do |x|
      Product.create(name: Faker::Commerce.product_name, item_number: Faker::Number.hexadecimal(Random.rand(4..10)).upcase, min_order_quantity: (Random.rand(1..100) * 5000), price: (Random.rand(1..500) * 50), description: Faker::Lorem.paragraph, buyer_id: ((i % 2) + 1), manufacturer_id: ((i * 10) + (j + 1)), category_id: (Random.rand(1..Category.count)))
    end
  end
end

10.times do |i|
  10.times do |j|
    AttendingManufacturer.create(trade_event_id: (i + 1), manufacturer_id: ((i * 10) + (j + 1)))
  end
end