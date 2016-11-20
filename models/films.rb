require_relative("../db/sql_runner")
require_relative("customers.rb")

class Film

  attr_reader :id
  attr_accessor :title, :price

  def initialize( options )
    @id = options[id].to_i
    @title = options['title']
    @price = options['price'].to_f
  end

  def save
    sql = "INSERT INTO films (title, price) VALUES ('#{ @title }', #{ price }) RETURNING id"
    film = SqlRunner.run( sql ).first
    @id = film['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM films;"
    films = SqlRunner.run( sql )
    return films.map { |hash| Film.new(hash) }
  end

  def update
    return unless @id
    sql = "UPDATE films SET 
          (title) = 
          ('#{@title}') WHERE id = #{@id};"
    SqlRunner.run( sql )
  end

  def delete
     return unless @id
     sql = "DELETE FROM films 
            WHERE id = #{@id};"
     SqlRunner.run( sql )
   end

   def self.delete_all() 
     sql = "DELETE FROM films;"
     SqlRunner.run(sql)
   end

   def self.get_many(sql)
     films = SqlRunner.run(sql)
     result = films.map { |film| Film.new( film ) }
     return result
   end

   def customer_tickets
      sql = "SELECT * FROM tickets WHERE film_id = #{ @id } ;"
      customers = Customer.get_many(sql)
      return customers
    end

    def total_customers
      return customers.count
    end



end