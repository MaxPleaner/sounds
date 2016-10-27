# standard library
require 'io/console'
require 'yaml'
require 'ostruct'
require 'securerandom'

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
$tempo_bpm = ENV["Tempo"] || 300.0

# start with the metronome off
$is_metronome_playing = false

# 8 beats is the default "time signature" (this is used by metronome)
$time_signature = ENV["TimeSignature"]&.to_i || 4.0

# start with recording off
$is_recording = false

# the most recent recording can be toggled on/off with /p
$is_last_recording_playing = false

# When including Sounds, some other modules/constants are loaded as well
# see lib/base.rb
module Sounds
  def self.included(base)
    super
    base.class_exec do
      include Sounds::Base
    end
  end
  def with_n_input_threads(n, &blk)
    n.times { Thread.new { blk.call } }
  end
end

class SoundsRunner
  include Sounds
  def initialize
    puts introduction
    # with_n_input_threads(20) { loop_input }
    loop_input
    # loop { sleep }
  end
end

# Run this unless the script is required
if __FILE__ == $0
  SoundsRunner.new
end