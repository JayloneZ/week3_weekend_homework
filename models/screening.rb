require_relative 'film.rb'
require_relative 'ticket.rb'

class Screening

attr_reader :id
attr_accessor :screening_time, :film_id
def initialize(options)
  @id = options['id'].to_i if options['id']
  @screening_time = options['screening_time']
  @film_id = options['film_id'].to_i
end

def save()
  sql = "
    INSERT INTO screenings
    (
      screening_time,
      film_id
    )
    VALUES
    (
      $1,
      $2
    )
    RETURNING *
  "
  values = [@screening_time, @film_id]
  @id = SqlRunner.run(sql, values)[0]['id'].to_i
end

def self.all()
  sql = "
    SELECT * FROM screenings
  "
  SqlRunner.run(sql, nil).map {|screening| Screening.new(screening)}
end

def self.delete_all()
  sql = "
    DELETE FROM screenings
  "
  SqlRunner.run(sql, nil)
end

def amount_of_customers()
  sql = "
    SELECT * FROM tickets
    WHERE screening_id = $1
  "
  values = [@id]
  SqlRunner.run(sql, values).map {|ticket| Ticket.new(ticket)}.length
end

end
