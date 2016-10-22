module Sounds::Introduction
  def introduction
    <<-TXT
============================
#{"welcome to sounds".blue}
- Enter control+c to quit
- Enter /k to print keymap
- Enter /r to start recording, and /r again to stop
============================

>>>
TXT
  end
end