require "rest-client"
require "securerandom"
require 'json'

def data 
  {
    id: SecureRandom.uuid.to_s,
    version: 1,
    t1: (15..23).to_a.sample.to_f,
    t2: (15..23).to_a.sample.to_f,
    rt1: (80..105).to_a.sample.to_f,
    rt2: (80..105).to_a.sample.to_f,
    timestamp: Time.now.to_i
  }
end

url = "http://localhost:9292/"
resource = RestClient::Resource.new(
  url,
  headers: {"Content-Type" => "application/vnd.eventstore.events+json"}
)

while true do 
  resource.post(data.to_json)
  sleep 1
end


