module Sounds::ArpeggiatorScales

  def self.default(options={})
    options = {
      min_num_steps: 1,
      max_num_step: 8,
      step_multiplier: 0.2
    }.merge options
    min, max, step_multiplier = options.values_at(*options.keys)
    [
      min.upto(max).to_a,
      max.downto(min).to_a
    ].flatten.map do |num_steps|
      num_steps.to_musical_scale_step.equal_temperament * step_multiplier
    end
  end

  def self.test(options={})
    4.times.flat_map { default.shuffle * 2 }
  end

end
   

