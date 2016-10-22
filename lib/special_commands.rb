module Sounds::SpecialCommands
  
  # load all the files in lib/special_commands and make their constants available here
  Dir.glob("./lib/special_commands/*.rb").each do |path|
    require path
    const_name = path.file_identifier.capitalize
    self.const_set(const_name, Object.const_get("Sounds::#{const_name}")) 
  end

  # When creating a new command make sure to add it to this list
  SpecialCommandList = [:k, :t, :h, :u, :s, :r]

  # keymap
  def k
    puts File.read 'keymap.yml'
  end

  # tempo
  def t
    original_tempo = $tempo_bpm
    next_input = get_char(true)
    cmd = { u: :up, d: :down, '=': :set }[next_input.to_sym]
    result = cmd ? Tempo.send(cmd) : (err && return)
    result || (err && return)
    puts "Changed tempo from #{original_tempo} to #{$tempo_bpm}"
  end

  # help
  def h
    puts introduction
  end

  # metronome
  def u
    $is_metronome_playing = ! $is_metronome_playing
    Thread.new do
      while $is_metronome_playing
        single_beat_duration = 60.0 / $tempo_bpm
        play "kick" # accent for the measure's beat 1
        ($time_signature).to_i.times do |i|
          sleep single_beat_duration
          play "hihat"
        end
      end
    end
  end

  # time signature
  def s
    puts "\nenter new time signature followed by new line"
    input = gets.chomp
    if input.is_number?
      $time_signature = input.to_f
      puts "changed time signature to #{$time_signature}"
    else
      puts "invalid time signature"
    end 
  end

  # record
  def r

end