require 'sinatra'

require 'opentracing'
require 'jaeger/client'
# require 'rack/tracer'

OpenTracing.global_tracer = Jaeger::Client.build(service_name: 'hello-world')

# use Rack::Tracer

get '/' do
    "#{hello} #{world}"
end

def hello
    client = Net::HTTP.new("localhost", 4567)
    req = Net::HTTP::Get.new("/")
    body = client.request(req).body
    OpenTracing.start_active_span("hello_world") do
        # OpenTracing.inject(env['rack.span'].context, OpenTracing::FORMAT_RACK, req)
        puts body
    end
    body
end

def world
    world_str = "world"
    OpenTracing.start_active_span("world_text") do
        puts world_str
    end

    world_str
end
