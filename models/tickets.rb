require_relative('../db/sql_runner')

class Ticket

attr_reader :id
attr_accessor :customer_id, :film_id

def initialize ( options )
  @id = options['id'].to_i if options['id']
  @film_id = options['film_id'].to_i
  @customer_id = options['customer_id'].to_i
end

# ============ Create ==============

def save()
  sql = "INSERT INTO tickets 
  (customer_id, film_id) 
  VALUES ($1, $2) 
  RETURNING id"
  values = [@customer_id, @film_id]
  # Breaking through the hash inside the array with the .first etc...
  ticket_save = SqlRunner.run(sql, values).first
  @id = ticket_save['id'].to_i
end

# ========== Read ===================

  def self.read_all()
    sql = "SELECT * FROM tickets"
    ticket_sales = SqlRunner.run(sql)
    return ticket_sales.map {|ticket_sales_hash| Ticket.new(ticket_sales_hash)}
  end

# ================ Update ============
# You can actually update the customer so they can see another film for example


# ============= Delete ===================

  def self.delete_all()
    sql = "DELETE FROM tickets"
    SqlRunner.run(sql)
  end


# =========== Finding all the tickets with a certain id ========== 

 def self.find(id)
    sql = "SELECT * FROM tickets WHERE customer_id = $1"
    values = [id]
    results = SqlRunner.run(sql, values)
    ticket_hash = results.first
    ticket_info = Ticket.new(ticket_hash)
    return ticket_info
  end

# Check how many tickets were bought by a customer






end