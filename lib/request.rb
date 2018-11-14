require 'benchmark'
require 'faraday'

module Monstress
  class Request

    attr_reader :method, :path, :body, :headers, :response_time

    def initialize(method: :get, path: '/', body: nil, headers: nil)
      @method = method
      @path = path
      @body = body
      @headers = headers
    end

    def send!
      @response_time = Benchmark.realtime do
        @response = connection.run_request(@method, @path, @body, @headers)
        raise @response.body if @response.status != 200
      end
    end

    private

    def connection
      @connection ||= Faraday.new(url: Monstress.configuration.host) do |conn|
        conn.basic_auth(*Monstress.configuration.basic_auth) if Monstress.configuration.basic_auth
        conn.adapter Faraday.default_adapter
      end
    end

  end
end
