module Monstress
  module Test
    class Suite
      # urls are go in format [<url>, <requests_count>]
      def initialize(targets)
        @targets = targets
      end

      def run!
        @requests = @targets.map { |t| spawn_requests(t) }
        run_requests @requests
      end

      def stats
        @requests.map { |r_list| Decorator.new(r_list) }
      end

      private

      def run_requests(requests)
        requests.each do |r_list|
          r_list.each(&:send!)
        end
      end

      def spawn_requests(target)
        Array.new(target.count) do
          Request.new(
            method: target.method,
            path: target.path,
            body: target.body,
            headers: target.headers
          )
        end
      end
    end
  end
end
