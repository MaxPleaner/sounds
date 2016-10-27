module Sounds::Base

  # copy all the constants of the class base is included in. This is because
  # base calls class_eval, so those constants won't otherwise be in scope
  def self.included(base)
    super
    base.class_exec do
      include Sounds::Loader
      include Sounds::Effects
      include Sounds::SpecialCommands
      include Sounds::Arpeggiator
      include Sounds::MusicalScaleStep::DefaultModifiers
      include Sounds::Introduction
    end
    base.constants.each do |konst|
      const_set konst, const_get("#{base}::#{konst}")
    end
  end

  KeymapPath = ENV["KeymapPath"] || "keymap.yml"
  
  SpecialCommandCharacter = ENV["SpecialCommandCharacter"] || "/"
  
  def self.play_file_with_mpg123(path)
    `mpg123 -o pulse #{path} > /dev/null 2>&1`
  end

  def get_char(should_print=false)
    input = STDIN.getch
    if input == "\u0003"
      `pkill mpg123`; puts 'goodbye'.green
      exit(1)
    end
    print(input) if should_print
    input
  end

  def err
    puts "\n\ninvalid command\n".red
    true # keep this here
  end

  def play(name)
    Thread.new { Sounds::Base.play_file_with_mpg123(mp3_path(name)) }
  end


  def process_special_command(input)
    if input == SpecialCommandCharacter
      print SpecialCommandCharacter
      special_command = get_char(true).to_sym rescue nil
      if self.class::SpecialCommandList.include? special_command
        send(special_command)
        puts "\n"
      else
        puts "command not recognized"
      end
      true
    else
      false
    end
  end

  def loop_input
    keymap = YAML.load File.read KeymapPath
    loop do
      input = get_char
      next if process_special_command(input)
      Thread.new { eval(keymap[input] || "") }
    end
  end
  
end