require 'sinatra'
require 'influxdb'
require 'json'

HOST = "influxdb"
PORT = "8086"
DATABASE = "wadus"
USER = "sensor"
PASSWORD = "8bbdb094-fe3e-4292-9b13-a8e19214083d"

def client
  @client ||= InfluxDB::Client.new(
    host: HOST,
    port: PORT,
    database: DATABASE,
    user: USER,
    password: PASSWORD
  )
end

post '/' do 
  payload = JSON.parse(request.body.read, symbolize_names: true)

  data = {
    values: { t1: payload[:t1], rt1: payload[:rt1], t2: payload[:t2], rt2: payload[:rt2] },
    tags:   { version: payload[:version], account: payload[:id] },
    timestamp: payload[:timestamp] 
  }

  client.write_point(name, data)
  [201]
end

get '/' do
  "hello world"
end
