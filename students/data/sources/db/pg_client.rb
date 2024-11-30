require 'pg'

class PG_client
  def initialize
    self.client = PG.connect(
      dbname: 'students',
      user: 'postgres',
      password: '1234',
      host: 'localhost',
      port: 5432
    )
  end

  def exec(query)
    client.exec(query)
  end

  private
  attr_accessor :client
end