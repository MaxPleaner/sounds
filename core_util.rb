class String

  def is_number?
    self =~ /^[0-9\.]+$/
  end

  def file_identifier
    # i.e. gets 'kick' from '/my/path/kick.mp3'
    File.basename self, ".*"
  end

end

Thread.abort_on_exception = true