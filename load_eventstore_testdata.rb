require "json"
require 'restclient'
require 'securerandom'


data = [
  {
    eventId: SecureRandom.uuid.to_s,
    eventType: "event-type",
    data: {
      a: "1"
    }
  }
]
url = "http://localhost:2113/streams/newstream"
response = RestClient::Resource.new(
          url,
          headers: {"Content-Type" => "application/vnd.eventstore.events+json"}
      ).post(data.to_json)

