require_relative( 'models/customers' )
require_relative( 'models/films' )
require_relative( 'models/tickets' )

require( 'pry-byebug' )

Customer.delete_all()
Film.delete_all()
Ticket.delete_all()

customer1 = Customer.new({'name' => 'Stan', 'funds' => 50})

customer2 = Customer.new({'name' => 'Cartman', 'funds' => 200})

customer3 = Customer.new({'name' => 'Kyle', 'funds' => 30})

customer4 = Customer.new({'name' => 'Kenny', 'funds' => 10})

customer1.save
customer1.funds = 30
customer1.update
customer2.save
customer3.save
customer4.save


film1 = Film.new({'title' => 'The Nutty Professor', 'price' => 10})

film2 = Film.new({'title' => 'The Nutty Professor II The Klumps', 'price' => 6})

film3 = Film.new({'title' => 'Norbit', 'price' => 10})

film4 = Film.new({'title' => 'Bowfinger', 'price' => 7})
film5 = Film.new({'title' => 'Terminator 2', 'price' => 4})

film1.save
film2.save
film3.save
film4.save
film5.save
film5.delete

ticket1 = Ticket.new({ 'customer_id' => customer1.id, 'film_id' => film1.id, 'film_time' => '1pm'})

ticket2 = Ticket.new({ 'customer_id' => customer2.id, 'film_id' => film2.id, 'film_time' => '5pm'})

ticket3 = Ticket.new({ 'customer_id' => customer3.id, 'film_id' => film3.id, 'film_time' => '8pm'})

ticket4 = Ticket.new({ 'customer_id' => customer4.id, 'film_id' => film4.id, 'film_time' => '6:30pm'})

ticket5 = Ticket.new({ 'customer_id' => customer2.id, 'film_id' => film1.id, 'film_time' => '9pm'})

ticket1.save
ticket2.save
ticket3.save
ticket4.save
ticket5.save

customer1.buy_ticket(film1)
customer1.update

binding.pry
nil