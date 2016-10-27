# There is no class managing collections of notes
# Rather, each note is identified by a scale and processed independently.
# Thus multiple scales can be easily mixed.

# Initialize is called with a number representing the number of steps
# traversed in the scale

# The instance methods return an integer, which is the number of steps multiplied
# by some factor

class Sounds::MusicalScaleStep

  module DefaultModifiers
    Phrygian = OpenStruct.new \
      default_step_multiplier: 1.0,
      default_step_adder: 0.0

    EqualTemperament = OpenStruct.new \
      default_step_multiplier: 1.0,
      default_step_adder: 0.0
  end

  def initialize(num_steps)
    @num_steps = num_steps.to_f
  end

  def equal_temperament
    [@num_steps, 1].max * Semitone
  end

  def phrygian
    notes = [1, 4, 5, 7, 8, 10, 12, 13, 16]
    idx = correct_idx(notes.length, @num_steps.to_i)
    notes[idx] * (Semitone)
  end

  private

  def correct_idx(arr_length, idx)
    max_idx = arr_length - 1
    if idx > max_idx
      idx = max_idx % idx
    end
    idx
  end

end
