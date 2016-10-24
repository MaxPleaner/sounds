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
    Sounds::MusicalScaleStep.new(self)
  end

end


# multithreading can be turned off, for debugging
# the reason for doing this would be to set breakpoints using byebug
if ENV["SINGLE_THREADED"]

  class Thread
    def self.new(&blk)
      blk.call
    end
  end

end

Thread.abort_on_exception = true

