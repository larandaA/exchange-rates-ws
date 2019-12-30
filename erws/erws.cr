require "cassandra/dbapi"
require "kemal"

class Bank

  JSON.mapping(
    id: String,
    name: String,
    rates: String,
  )

  Object.def_clone

  def self.from(id : String, name : String) : Bank
    Bank.from_json({
      "id": id,
      "name": name,
      "rates": "/banks/#{id}/rates",
    }.to_json)
  end

end

class Rate

  JSON.mapping(
    cost: Float32,
    lastUpdate: Time,
    fromUnit: Float32,
    fromName: String,
    toUnit: Float32,
    toName: String,
  )

  Object.def_clone

  def self.from(cost : Float32, last_update : Time) : Rate
    Rate.from_json({
      "cost": cost,
      "lastUpdate": last_update,
      "fromUnit": 1.0,
      "fromName": "USD",
      "toUnit": 1.0,
      "toName": "EUR",
    }.to_json)
  end

end

class ExchangeRate

  JSON.mapping(
    bank: Bank,
    rate: Rate,
    self: String,
  )

  Object.def_clone

  def self.from(id : String, name : String, cost : Float32, last_update : Time) : ExchangeRate
    ExchangeRate.from_json({
      "bank": Bank.from(id: id, name: name),
      "rate": Rate.from(cost: cost, last_update: last_update),
      "self": "/banks/#{id}/rates",
    }.to_json)
  end

end

DB.open "cassandra://localhost/erws" do |db|

  min_rate = -> {  
    result = nil

    sql = "SELECT id, name, cost, last_update FROM bank"
    db.query sql do |rows|
      rows.each do
        id = rows.read(String)
        name = rows.read(String)
        cost = rows.read(Float32)
        last_update = rows.read(Time)
        if result.nil? || cost < result.rate.cost
          result = ExchangeRate.from(id: id, name: name, cost: cost, last_update: last_update)
        end
      end
    end

    result.not_nil!
  }

  min_rate_except = ->(bank_id : String) {
    result = nil

    sql = "SELECT id, name, cost, last_update FROM bank"
    db.query(sql) do |rows|
      rows.each do
        id = rows.read(String)
        name = rows.read(String)
        cost = rows.read(Float32)
        last_update = rows.read(Time)
        next if id == bank_id
        if result.nil? || cost < result.rate.cost
          result = ExchangeRate.from(id: id, name: name, cost: cost, last_update: last_update)
        end
      end
    end

    result
  }

  min_rate_cache = min_rate.call

  before_all do |env|
    env.response.content_type = "application/json"
  end

  error 404 do |env|
    path = env.request.path
    {"error": "This path does not exist: #{path}"}.to_json
  end

  get "/banks/:id/rates" do |env|
    id = env.params.url["id"]

    sql = "SELECT name, cost, last_update FROM bank WHERE id = ?"
    name, cost, last_update = db.query_one sql, id, as: { String, Float32, Time}
    
    response = ExchangeRate.from(id: id, name: name, cost: cost, last_update: last_update)
    response.to_json
  end

  put "/banks/:id/rates" do |env|
    id = env.params.url["id"]
    erate = ExchangeRate.from_json(env.params.json.to_json)
    cost = erate.rate.cost
    last_update = erate.rate.lastUpdate

    sql = "SELECT name FROM bank WHERE id = ?"
    name = db.query_one sql, id, as: { String }

    sql = "UPDATE bank SET cost = ?, last_update = ? WHERE id = ?"
    db.exec sql, cost, last_update, id

    response = ExchangeRate.from(id: id, name: name, cost: cost, last_update: last_update)
    
    old_min_rate = min_rate_except.call(id)
    if old_min_rate.nil? || cost < old_min_rate.rate.cost
      min_rate_cache = response
    else
      min_rate_cache = old_min_rate
    end

    response.to_json
  end

  get "/rates" do |env|
    sql = "SELECT id, name, cost, last_update FROM bank"
    
    rates = Array(ExchangeRate).new

    db.query sql do |rows|
      rows.each do
        id = rows.read(String)
        name = rows.read(String)
        cost = rows.read(Float32)
        last_update = rows.read(Time)
        rates << ExchangeRate.from(id: id, name: name, cost: cost, last_update: last_update)
      end
    end

    { "rates": rates, "self": "/rates" }.to_json
  end

  get "/rates/min" do |env|
    response = min_rate_cache.clone
    response.self = "/rates/min"
    response.to_json
  end

  Kemal.run

end

