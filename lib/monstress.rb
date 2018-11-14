require_relative 'configuration'
require_relative 'request'
require_relative 'decorator'
require_relative 'test/test'

module Monstress
  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    yield configuration
  end
end
