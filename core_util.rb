
# Musical stuff
Semitone = 2.0 ** (1.0 / 12.0)
def one_divided_by(n)
  1.0 / n.to_f
end
def gen_id
  SecureRandom.urlsafe_base64
end

# File patch
class File
  def self.most_recently_edited(glob)
    Dir.glob(glob).max_by { |f| File.mtime(f) }
  end
end

# String patch
class String

  def is_number?
    self =~ /^[0-9\.]+$/
  end

  def file_identifier
    # i.e. gets 'kick' from '/my/path/kick.mp3'
    File.basename self, ".*"
  end

end

# Integer patch
class Integer

  # integer in this context means number of steps up in a musical scale
  # see MusicalScale instance methods which return a delta percentage
  # depending on which scale is used. 
  def to_musical_scale_step
    Sounds::MusicalScaleStep.new(self)
  end

end

# Thread patch

Thread.abort_on_exception = true

# multithreading can be turned off, for debugging
# the reason for doing this would be to set breakpoints using byebug
if ENV["SINGLE_THREADED"]

  class Thread
    def self.new(&blk)
      blk.call
    end
  end

end


