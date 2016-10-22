# standard library
require 'io/console'
require 'yaml'

# gems
require 'awesome_print' 
require 'colored'
require 'active_support/all'

# debugging gems
require 'byebug'

# extensions to ruby
require_relative "./core_util.rb"

# Base module extended by other files
module Sounds; end

# Require those other files
Dir.glob("./lib/*.rb").each { |path| require path }

$tempo_bpm = ENV["Tempo"] || 120.0
$is_metronome_playing = false
$time_signature = ENV["TimeSignature"]&.to_i || 8.0

# When including Sounds, some other modules/constants are loaded as well
module Sounds
  attr_accessor :tempo_bpm, :is_metronome_playing, :time_signature
  def self.included(base)
    super
    base.class_exec do
      include Sounds::Introduction
      include Sounds::Base
      include Sounds::Loader
      include Sounds::Effects
      include Sounds::Tempo
      include Sounds::SpecialCommands
    end
  end
end

# Run this unless the script is required
if __FILE__ == $0
  class Runner
    include Sounds
    def initialize
      puts introduction
      loop_input
    end
  end
  Runner.new
end