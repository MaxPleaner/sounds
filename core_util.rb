require './lib/musical_scale_step'

class String

  def is_number?
    self =~ /^[0-9\.]+$/
  end

  def file_identifier
    # i.e. gets 'kick' from '/my/path/kick.mp3'
    File.basename self, ".*"
  end

end

class Integer

  # integer in this context means number of steps up in a musical scale
  # see MusicalScale instance methods which return a delta percentage
  # depending on which scale is used. 
  def to_musical_scale_step
    MusicalScaleStep.new(self)
  end

end


Thread.abort_on_exception = true

