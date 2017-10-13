require_relative 'film.rb'
require_relative '../db/sql_runner.rb'

class Customer

attr_reader :id
attr_accessor :funds, :name
  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @funds = options['funds'].to_i
  end

  def save()
    sql = "
      INSERT INTO customers
      (
        name,
        funds
      )
      VALUES
      (
        $1,
        $2
      )
      RETURNING *
    "
    values = [@name, @funds]
    @id = SqlRunner.run(sql, values)[0]['id'].to_i
  end

  def self.all()
    sql = "
      SELECT * FROM customers
    "
    SqlRunner.run(sql, nil).map {|customer| Customer.new(customer)}
  end

  def self.delete_all()
    sql = "
      DELETE FROM customers
    "
    SqlRunner.run(sql, nil)
  end

  def delete()
    sql = "
      DELETE FROM customers
      WHERE id = $1
    "
    values = [@id]
    SqlRunner.run(sql, values)
    Customer.all()
  end

  def update()
    sql = "
      UPDATE customers
      SET
      (
        name,
        funds
      ) =
      (
        $1,
        $2
      )
      WHERE id = $3
      RETURNING *
    "
    values = [@name, @funds, @id]
    result = SqlRunner.run(sql, values)[0]
    return Customer.new(result)
  end

  def show_films()
    sql = "
      SELECT films.* FROM films
      INNER JOIN tickets
      ON films.id = tickets.film_id
      WHERE customer_id = $1
    "
    values = [@id]
    SqlRunner.run(sql, values).map {|film| Film.new(film)}
  end

end
