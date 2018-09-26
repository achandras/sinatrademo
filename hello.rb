require 'sinatra'

require 'opentracing'
require 'jaeger/client'
# require 'rack/tracer'

# OpenTracing.global_tracer = Jaeger::Client.build(service_name: "ruby_test")
OpenTracing.global_tracer = Jaeger::Client.build(service_name: "ruby_test_http", host: "http://localhost", port: 14268, http: true)

# use Rack::Tracer

get '/' do
    "#{hello}"
end

def hello
    hello_str = "hello"
    OpenTracing.start_active_span("hello") do
        puts hello_str
    end
    return hello_str
end
