require_relative("../db/sql_runner")
require_relative("films.rb")

class Customer

  # attr_reader :id
  attr_accessor :id, :name, :funds

  def initialize( options )
    @id = options['id'].to_i if options["id"]
    @name = options['name']
    @funds = options['funds'].to_f
  end

  def save
    sql = 
    "INSERT INTO customers 
    (name, funds) 
    VALUES 
    ('#{ @name }', #{ @funds }) RETURNING id"
    location = SqlRunner.run( sql ).first
    @id = location['id'].to_i
  end

  def self.all
    sql = "SELECT * FROM customers;"
    customers = SqlRunner.run( sql )
    return customers.map { |hash| Customer.new(hash) }
  end

 def update
    return unless @id
    sql = "UPDATE customers SET 
       (name, funds) = 
       ('#{@name}', #{@funds}) 
       WHERE id = #{@id};"
    SqlRunner.run( sql )
  end

  def delete
    return unless @id
    sql = "DELETE FROM customers WHERE id = #{@id};"
    SqlRunner.run( sql )
  end

  def self.delete_all() 
     sql = "DELETE FROM customers;"
     SqlRunner.run(sql)
  end

   def self.get_many(sql)
     customers = SqlRunner.run(sql)
     result = customers.map { |customer| Customer.new( customer ) }
     return result
   end

   def tickets()
      sql = "SELECT * FROM tickets WHERE customer_id = #{ @id } ;"
      tickets = Ticket.get_many(sql)
      return tickets
    end

    def buy_ticket(film)
       @funds -= film.price
       update()
    end

    def tickets_bought()
      tickets.count
    end
end