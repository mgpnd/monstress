module Monstress
  module Test
    class Target
      attr_accessor :path, :count, :method, :body, :headers

      def initialize(path, count, method = get, body = nil, headers = nil)
        @path = path
        @count = count
        @method = method
        @body = body
        @headers = headers
      end
    end
  end
end
