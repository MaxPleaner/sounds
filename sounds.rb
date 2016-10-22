require 'io/console'
require 'byebug'
require 'awesome_print'
require 'colored'
require 'yaml'

require_relative "./core_util.rb"

# Base module extended by other files
module Sounds; end

# Require those other files
Dir.glob("./sounds/*.rb").each { |path| require path }

# Set a global tempo
$tempo = ENV["Tempo"] || 120.0

# A global variable representing the metronome state (is it playing?)
$metronome_playing = false

# When including Sounds, some other modules/constants are loaded as well
module Sounds
  def self.included(base)
    super
    base.class_exec do
      include Sounds::Introduction
      include Sounds::Base
      include Sounds::Loader
      include Sounds::Effects
      include Sounds::SpecialCommands
    end
  end
end

if __FILE__ == $0
  include Sounds
  puts introduction
  loop_input
end