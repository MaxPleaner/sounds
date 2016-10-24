# see core_utils.rb for the Integer#to_musical_scale_step method used here
# see lib/musical_scale_step.rb as well

module Sounds::ArpeggiatorScales

  def self.scale(options={})
    options = {
      min_num_steps: 1,
      max_num_step: 8,
      step_multiplier: 1.0,
      step_adder: 0.0,
      scale: :equal_temperament
    }.merge options
    min, max, step_multiplier, step_adder, scale = options.values_at(*options.keys)
    min.upto(max).to_a.map do |num_steps|
      (num_steps.to_musical_scale_step.send(scale) * step_multiplier) + step_adder
    end
  end

  def self.random(options={})
    scale(options).shuffle
  end

end
   

