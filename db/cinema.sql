DROP TABLE tickets;
DROP TABLE screenings;
DROP TABLE films;
DROP TABLE customers;


CREATE TABLE customers(
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(255),
  funds INT4
);

CREATE TABLE films(
  id SERIAL4 PRIMARY KEY,
  title VARCHAR(255),
  price INT4
);

CREATE TABLE screenings(
  id SERIAL4 PRIMARY KEY,
  film_id SERIAL4 REFERENCES films(id),
  screening_time VARCHAR(255)
);


CREATE TABLE tickets(
  id SERIAL4 PRIMARY KEY,
  customer_id SERIAL4 REFERENCES customers(id),
  screening_id SERIAL4 REFERENCES screenings(id),
  film_id SERIAL4 REFERENCES films(id)
);
