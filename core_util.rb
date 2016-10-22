class String
  def is_number?
    self =~ /^[0-9\.]+$/
  end
end