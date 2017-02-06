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