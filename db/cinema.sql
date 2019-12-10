DROP TABLE tickets;
DROP TABLE films;
DROP TABLE customers;


CREATE TABLE customers (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  funds INT
);

CREATE TABLE films (
  id SERIAL PRIMARY KEY,
  title VARCHAR(255),
  price VARCHAR(255)
  -- READ BELOW
);


CREATE TABLE tickets (
  id SERIAL PRIMARY KEY,
  customer_id INT REFERENCES customers(id) ON DELETE CASCADE,
  film_id INT REFERENCES films(id) ON DELETE CASCADE
);





-- I was going to put the customer id in films as I got the error messege 
-- I was referring to the music lab where artists was in albums
-- This tied together artists and albums in the same way we want to tie together films and customers



-- [1] pry(main)> customer1.films_customer_sees()
-- PG::UndefinedColumn: ERROR:  column "customers_id" does not exist
-- LINE 1: SELECT * FROM films WHERE customers_id = $1

-- my code did not work as it was unable to confirm the customers_id i was giving witht the customer_id in 
-- the film table because it did not exist.  