module Sounds::SpecialCommands
  
  SpecialCommandList = [:k, :t, :h, :u]

  def k
    puts File.read 'keymap.yml'
  end

  def t
    original_tempo = $tempo
    next_input = get_char(true)
    type = case next_input
    when "u" then :up
    when "d" then :down
    when "=" then :set
    else nil
    end
    if !type
      puts "invalid command"; return
    else
      if type == :set
        puts "\n enter tempo followed by new line"
        new_tempo = gets.chomp
        if new_tempo.is_number?
          $tempo = new_tempo.to_f
        else
          puts "invalid command"; return
        end
      else
        puts "\n enter amount to increase followed by new line"
        amt = gets.chomp
        if amt.is_number?
          if type == :up
            $tempo += amt.to_f
          else
            $tempo -= amt.to_f
          end
        else
          puts "invalid command"; return
        end
      end
    end
    puts "Changed tempo from #{original_tempo} to #{$tempo}"
  end

  def h
    puts introduction
  end

  def u
    $metronome_playing = ! $metronome_playing
    Thread.new do
      while $metronome_playing
        play "hihat"
        sleep 30.0 / $tempo
      end
    end
  end

end