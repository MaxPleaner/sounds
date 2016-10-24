# see core_utils.rb for the Integer#to_musical_scale_step method used here
# see lib/musical_scale_step.rb as well

module Sounds::ArpeggiatorScales

  def self.up_and_down(options={})
    options = {
      min_num_steps: 0,
      max_num_step: 8,
      step_multiplier: 1.0,
      scale: :equal_temperament
    }.merge options
    min, max, step_multiplier, scale = options.values_at(*options.keys)
    [
      min.upto(max).to_a,
      max.downto(min).to_a
    ].flatten.map do |num_steps|
      num_steps.to_musical_scale_step.send(scale) * step_multiplier
    end
  end

  def self.random(options={})
    4.times.flat_map { up_and_down.shuffle * 2 }
  end

end
   

