require 'pry'
require_relative '../models/customer.rb'
require_relative '../models/film.rb'
require_relative '../models/ticket.rb'

Ticket.delete_all
Screening.delete_all
Customer.delete_all
Film.delete_all

customer1 = Customer.new({
  'name' => 'Huascar',
  'funds' => '10'
})
customer1.save()

customer2 = Customer.new({
  'name' => 'Yoni',
  'funds' => '10'
})
customer2.save()

film1 = Film.new({
  'title' => 'My Little Pony - The Movie',
  'price' => '5',
})
film1.save()

film2 = Film.new({
  'title' => 'Rock Hard: The Story of Stonehenge',
  'price' => '100',
})
film2.save()

screening1 = Screening.new({
  'film_id' => film1.id,
  'screening_time' => '13:00'
})
screening1.save()

screening2 = Screening.new({
  'film_id' => film2.id,
  'screening_time' => '12:00'
})
screening2.save()

screening3 = Screening.new({
  'film_id' => film2.id,
  'screening_time' => '14:00'
})
screening3.save()

ticket1 = Ticket.new({
  'customer_id' => customer1.id,
  'screening_id' => screening3.id,
  'film_id' => screening3.film_id
})
ticket1.save()

ticket2 = Ticket.new({
  'customer_id' => customer1.id,
  'screening_id' => screening2.id,
  'film_id' => screening2.film_id
})
ticket2.save()

ticket3 = Ticket.new({
  'customer_id' => customer2.id,
  'screening_id' => screening2.id,
  'film_id' => screening2.film_id
})
ticket3.save()

binding.pry
nil
