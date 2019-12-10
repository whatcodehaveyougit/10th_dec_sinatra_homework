require_relative('../db/sql_runner')

class Film

attr_reader :id
attr_accessor :title, :price

def initialize ( options )
  @id = options['id'].to_i if options ['id']
  @title = options['title']
  @price = options['price']
end

# =========== CREATE =============

def save()
  sql="INSERT INTO films
  (title, price)
  VALUES ($1, $2)
  RETURNING id"
  values = [@title, @price]
  film_save = SqlRunner.run(sql, values).first
  @id = film_save['id'].to_i
end


# ============ READ ===============

  def self.read_all()
    sql = "SELECT * FROM films"
    films_showing = SqlRunner.run(sql)
    return films_showing.map {|films_hash| Film.new(films_hash)}
  end

  def self.find_film_by_id(id)
    sql = "SELECT * FROM films WHERE id = $1"
    values = [id]
    film = SqlRunner.run(sql, values)
    return Film.new(film.first)
  end
# ========== UPDATE ===========

  def update
    sql = "UPDATE films SET (title, price) = ($1, $2)
    WHERE id = $3"
    values = [@title, @price, @id]
    SqlRunner.run(sql, values)
      return values
  end



# ============== DELETE ===============

def self.delete_all()
  sql = "DELETE FROM films"
  SqlRunner.run(sql)
end

# Why is it returning the film data rather than the customer data?

def customers_at_film()
  sql = "SELECT * FROM customers INNER JOIN tickets
  ON customers.id = tickets.customer_id WHERE film_id = $1"
  values = [@id]
  customers = SqlRunner.run(sql, values)
  result = customers.map {|customer_hash| Customer.new(customer_hash)}
end







end
