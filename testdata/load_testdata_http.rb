require "rest-client"
require "securerandom"

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

url = "http://ec2-35-156-110-236.eu-central-1.compute.amazonaws.com:9292/"
resource = RestClient::Resource.new(
  url,
  headers: {"Content-Type" => "application/vnd.eventstore.events+json"}
)

while true do 
  resource.post(data.to_json)
  sleep 1
end


