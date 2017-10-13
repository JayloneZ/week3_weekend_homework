require 'pg'


class SqlRunner

def self.run(sql, values)
  begin
    db = PG.connect({
      dbname: 'cinema',
      host: 'localhost'
    })
    db.prepare("function", sql)
    result = db.exec_prepared("function", values)
  ensure
    db.close()
  end
  return result
end

end
