require_relative("../db/sql_runner")
require_relative("films.rb")
require_relative("customers.rb")

class Ticket

  attr_reader :id
  attr_accessor :film_id, :customer_id, :film_time

  def initialize( options )
    @id = options['id'].to_i if options['id']
    @film_id = options['film_id'].to_i
    @customer_id = options['customer_id'].to_i
    @film_time = options['film_time']
  end

  def save
    sql = "INSERT INTO tickets (film_id, customer_id, film_time) VALUES (#{ @film_id }, #{ @customer_id }, '#{ @film_time }' ) RETURNING id;"
    ticket = SqlRunner.run( sql ).first
    @id = ticket['id'].to_i
  end

  def self.all
     sql = "SELECT * FROM tickets;"
     tickets = SqlRunner.run( sql )
     return tickets.map { |hash| Ticket.new(hash) }
  end

   def delete
      return unless @id
      sql = "DELETE FROM films WHERE id = #{@id};"
      SqlRunner.run( sql )
    end

  def self.delete_all() 
    sql = "DELETE FROM tickets;"
    SqlRunner.run(sql)
  end

  def self.get_many(sql)
      tickets = SqlRunner.run(sql)
      result = tickets.map { |ticket| Ticket.new( ticket ) }
      return result
  end

end