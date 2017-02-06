require "kafka"
require 'json'
require "avro_turf"

avro = AvroTurf.new(schemas_path: "schemas/")

kafka = Kafka.new(
  # At least one of these nodes must be available:
  seed_brokers: ["http://localhost:9092"],

  # Set an optional client id in order to identify the client to Kafka:
  client_id: "my-application",
)

#kafka.deliver_message("Hello, World!", topic: "moisture-topic")

producer = kafka.producer

# Add a message to the producer buffer.
event = {
  values: { value: 456 },
  tags:   { account: 'kafka' } # tags are optional
}
#event = {
#  key: "foo",
#  value: "bar"
#}
data =  avro.encode(event, schema_name: "moisture")
producer.produce(data, topic: "moisture-topic6")

# Deliver the messages to Kafka.
producer.deliver_messages