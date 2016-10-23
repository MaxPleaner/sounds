module Sounds::Introduction
  def introduction
    <<-TXT

============================

#{"welcome to sounds".yellow}

#{"Commands".bold}:
  
  Quit:
     - #{"control+c".green}

  Help:
     - #{"/h".green}

  Print keymap:
     - #{"/k".green}

  Tempo:
     - effects can use the Tempo constant to access this (it defaults to 120)
     - increase by N: #{"/tu".green}
     - decrease by N: #{"/td".green}
     - set to N: #{"/t".green}

  Metronome:
     - start and stop with #{"/u".green}
     - responds to changes in tempo and time signature

  Time signature
     - set to N: #{"/s".green}

  Record
      - start and stop with #{"/r".green} 
   

  
============================

>>>
TXT
  end
end
