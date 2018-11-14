module Monstress
  class Decorator
    def initialize(requests)
      @requests = requests
    end

    def to_s
      timings = @requests.map(&:response_time)
      <<~HEREDOC
        URL: #{@requests.first.path}
        Count: #{@requests.size}
        Timings: #{timings_list timings}
        Average: #{timings_average timings}
        Median: #{timings_median timings}

      HEREDOC
    end

    def average(values)
      values.reduce(&:+) / values.size.to_f
    end

    def median(values)
      values = values.sort
      if values.size.odd?
        values[values.size / 2]
      else
        values[values.size / 2 - 1, 2].reduce(&:+) / 2.to_f
      end
    end

    def timings_list(timings)
      timings.map { |t| (t * 1000).round(2) }.join(', ')
    end

    def timings_average(timings)
      (average(timings) * 1000).round(2)
    end

    def timings_median(timings)
      (median(timings) * 1000).round(2)
    end
  end
end
