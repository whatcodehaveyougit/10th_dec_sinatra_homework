require_relative ('../db/sql_runner')

class Customer

  attr_reader :id 
  attr_accessor :name, :funds

  def initialize ( options ) 
    @id = options['id'].to_i if options ['id']
    @name = options['name']
    @funds = options['funds'].to_i
  end

  # ========== CREATE ============

  def save()
    sql = "INSERT INTO customers
    (name, funds)
    VALUES($1, $2)
    RETURNING id"
    values = [@name, @funds]
    customer_save = SqlRunner.run(sql, values).first
    @id = customer_save['id'].to_i
    # this runs every time we do the ruby console.rb - STORES the @id so it is accessible.
  end


# ============= READ =============

  def self.read_all()
    sql = "SELECT * FROM customers"
    customer_records = SqlRunner.run(sql)
    return customer_records.map {|customer_hash| Customer.new(customer_hash)}
  end

  # ========= Update ==================

  def update()
    sql = "UPDATE customers SET (name, funds) = ($1, $2) 
    WHERE id = $3"
    values = [@name, @funds, @id]
    SqlRunner.run(sql, values)
    return values
  end

  # ============= DELETE =============

  def self.delete_all()
    sql = "DELETE FROM customers"
    SqlRunner.run(sql)
  end

  def delete()
    sql = "DELETE FROM customer where id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end


# ======== MVP - shows which films a customer has tickets to see =============

def films_customer_sees()
  sql = "SELECT * FROM films INNER JOIN tickets
  ON films.id = tickets.film_id WHERE customer_id = $1"
  values = [@id]
  films = SqlRunner.run(sql, values)
  result = films.map {|film_hash| Film.new(film_hash)}
  return result
end





# Extension 1 - Reducing the customers funds when buying a ticket
# This function updates the funds in the SQL database and ruby.!

  def customer_buys_ticket_two()
    @funds -= get_price_of_film()
    sql = "UPDATE customers SET funds = $1 WHERE id = $2"
    values = [ @funds, @id ]
    SqlRunner.run(sql, values)
  end

  def get_price_of_film()
    sql = "SELECT films.price FROM films"
    funds_hash = SqlRunner.run(sql).first
    @funds = funds_hash['price'].to_i
    return @funds
  end

  def customer_buys_ticket()
  @funds -= 10 
  sql = "UPDATE customers SET funds = $1
    WHERE id = $2"
    values = [@funds, @id]
    SqlRunner.run(sql, values)
    return values
  end

def number_of_tickets_bought
end

    

 # def update()
 #    sql = "UPDATE customers SET (name, funds) = ($1, $2) 
 #    WHERE id = $3"
 #    values = [@name, @funds, @id]
 #    SqlRunner.run(sql, values)
 #    return values
 #  end



end