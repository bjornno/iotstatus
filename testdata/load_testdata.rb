require "influxdb"
require "securerandom"

module InfluxDB
  module Playground
    class Populator
      HOST     = "ec2-35-156-110-236.eu-central-1.compute.amazonaws.com"
      PORT     = "8086"
      DATABASE = "wadus"
      USER     = "sensor"
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

#      min lekse:
#      få noe til å kjøre på aws google 
#      https
#      persistent database

#      {
#        "version": "1",
#        "id": "jshdkjsandkjsd",
#        "timestamp": "2015-02-02T12:12:12Z",
#        "t1": 4,
#        "rf1": 56,
#        "t2": 5,
#        "rf2": 65
#      }

      def data_points
        name     = 'sensordata'
        accounts = ["d7b3e200-9587-44fc-a333-5c5724691049", "4560a663-ea8c-4f97-a4d4-f005a30d3697", "6061ba6f-cb79-418b-b4a4-11cfc3436c61"]
        loop do
          data = {
            values: { t1: (15..23).to_a.sample.to_f, rt1: (80..105).to_a.sample.to_f, t2: (15..23).to_a.sample.to_f, rt2: (80..105).to_a.sample.to_f },
            tags:   { version: "1", account: accounts.sample }, # tags are optional
            timestamp: Time.now.to_i
          }

          client.write_point(name, data)

          sleep 1
        end
      end
    end
  end
end


populator = InfluxDB::Playground::Populator.new
populator.data_points