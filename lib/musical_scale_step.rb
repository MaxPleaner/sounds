# There is no class managing collections of notes
# Rather, each note is identified by a scale and processed independently.
# Thus multiple scales can be easily mixed.

# Initialize is called with a number representing the number of steps
# traversed in the scale

# The instance methods return an integer, which is the number of steps multiplied
# by some factor

class MusicalScaleStep
  
  Twelth_Root_Of_Two = 2.0 ** (1.0 / 12.0)

  def initialize(num_steps)
    @num_steps = num_steps
  end

  def equal_temperament
    @num_steps * Twelth_Root_Of_Two
  end

end
