require "influxdb"

module InfluxDB
  module Playground
    class Populator
      HOST     = "localhost"
      PORT     = "8086"
      DATABASE = "wadus"
      USER     = "root"
      PASSWORD = "root"

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
        name     = 'moisture'
        loop do
          data = {
            values: { value: (80..105).to_a.sample.to_f },
            tags:   { account: ['a', 'b', 'c'].sample } # tags are optional
          }

          client.write_point(name, data)

          sleep 1
        end
      end
    end
  end
end

20k*365*20

populator = InfluxDB::Playground::Populator.new
populator.data_points