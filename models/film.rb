require_relative 'customer.rb'
require_relative '../db/sql_runner.rb'


class Film

  attr_reader :id
  attr_accessor :price, :title
  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @price = options['price'].to_i
  end

  def save()
    sql = "
      INSERT INTO films
      (
        title,
        price
      )
      VALUES
      (
        $1,
        $2
      )
      RETURNING *
    "
    values = [@title, @price]
    @id = SqlRunner.run(sql, values)[0]['id'].to_i
  end

  def self.all()
    sql = "
      SELECT * FROM films
    "
    SqlRunner.run(sql, nil).map {|film| Film.new(film)}
  end

  def self.delete_all()
    sql = "
      DELETE FROM films
    "
    SqlRunner.run(sql, nil)
  end

  def delete()
    sql = "
      DELETE FROM films
      WHERE id = $1
    "
    values = [@id]
    SqlRunner.run(sql, values)
    Film.all()
  end

  def update()
    sql = "
      UPDATE films
      SET
      (
        title,
        price
      ) =
      (
        $1,
        $2
      )
      WHERE id = $3
      RETURNING *
    "
    values = [@title, @price, @id]
    result = SqlRunner.run(sql, values)[0]
    return Film.new(result)
  end

  def show_customers()
    sql = "
      SELECT customers.* FROM customers
      INNER JOIN tickets
      ON customers.id = tickets.customer_id
      WHERE film_id = $1
    "
    values = [@id]
    SqlRunner.run(sql, values).map {|customer| Customer.new(customer)}
  end

  def amount_of_customers()
    sql = "
      SELECT * FROM tickets
      WHERE film_id = $1
    "
    values = [@id]
    SqlRunner.run(sql, values).map {|ticket| Ticket.new(ticket)}.length
  end

end
