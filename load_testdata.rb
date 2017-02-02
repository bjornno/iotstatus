require "influxdb"

module InfluxDB
  module Playground
    class Populator
      HOST     = "localhost"
      PORT     = "8086"
      DATABASE = "wadus"
      USER     = "root"
      PASSWORD = "root"

      # def write_data_points
      #   100.times do 
      #     client.write_points(data_points)
      #   end
      # end

      

      def client
        @client ||= InfluxDB::Client.new(
          host: HOST,
          port: PORT,
          database: DATABASE,
          user: USER,
          password: PASSWORD
        )
      end

      # Enumerator that emits a sine wave
      Value = (0..360).to_a.map {|i| rand(i) }.each
      def data_points
        accounts = ['a', 'b', 'c']
        name     = 'moisture'

        loop do
          data = {
            values: { value: Value.next.to_f },
            tags:   { account: accounts.sample } # tags are optional
          }

          client.write_point(name, data)

          sleep 1
        end
      end
      # def data_points
      #   [
      #     {
      #       series: "score",
      #       values: { value: rand(200) }
      #     },
      #     {
      #       series: "searches",
      #       values: { value: rand(200) }
      #     }
      #   ]
      # end
    end
  end
end

populator = InfluxDB::Playground::Populator.new
populator.data_points