require 'io/console'
require 'byebug'
require 'awesome_print'
require 'yaml'

# Base module extended by other files
module Sounds; end

# Require those other files
Dir.glob("./sounds/*.rb").each { |path| require path }

# When including Sounds, some other modules/constants are loaded as well
module Sounds
  def self.included(base)
    super
    base.class_exec do
      include Sounds::Introduction
      include Sounds::Base
      include Sounds::Loader
      include Sounds::Effects
    end
  end
end

if __FILE__ == $0
  include Sounds
  puts introduction
  loop_input
end