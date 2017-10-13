require_relative 'customer.rb'
require_relative 'film.rb'
require_relative '../db/sql_runner.rb'

class Ticket

attr_reader :id
attr_accessor :customer_id, :film_id
  def initialize(options)
    @id = options['id'].to_i if options['id']
    @customer_id = options['customer_id'].to_i
    @film_id = options['film_id'].to_i
  end

  def save()
    sql = "
      INSERT INTO tickets
      (
        customer_id,
        film_id
      )
      VALUES
      (
        $1,
        $2
      )
      RETURNING *
    "
    values = [@customer_id, @film_id]
    result = SqlRunner.run(sql, values)[0]
    @id = result['id'].to_i
    for customer in Customer.all
      if result['customer_id'] = customer.id
        for film in Film.all
          if result['film_id'] = film.id
            customer.funds -= film.price
          end
        end
      end
    end
  end

  def self.all()
    sql = "
      SELECT * FROM tickets
    "
    SqlRunner.run(sql, nil).map {|ticket| Ticket.new(ticket)}
  end

  def self.delete_all()
    sql = "
      DELETE FROM tickets
    "
    SqlRunner.run(sql, nil)
  end

  def delete()
    sql = "
      DELETE FROM tickets
      WHERE id = $1
    "
    values = [@id]
    SqlRunner.run(sql, values)
    Customer.all()
  end

  def update()
    sql = "
      UPDATE tickets
      SET
      (
        customer_id,
        film_id
      ) =
      (
        $1,
        $2
      )
      WHERE id = $3
      RETURNING *
    "
    values = [@customer_id, @user_id, @id]
    result = SqlRunner.run(sql, values)[0]
    return Ticket.new(result)
  end

end
