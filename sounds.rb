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

# initialize with a tempo
$tempo_bpm = ENV["Tempo"] || 120.0

# start with the metronome off
$is_metronome_playing = false

# 8 beats is the default "time signature" (this is used by metronome)
$time_signature = ENV["TimeSignature"]&.to_i || 8.0

# start with recording off
$is_recording = false

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