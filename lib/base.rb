module Sounds::Base

  KeymapPath = ENV["KeymapPath"] || "keymap.yml"
  
  SpecialCommandCharacter = ENV["SpecialCommandCharacter"] || "/"

  def get_char(should_print=false)
    input = STDIN.getch
    exit(1) if input == "\u0003"
    print(input) if should_print
    input
  end

  def err
    puts "\n\ninvalid command\n".red
    true # keep this here
  end

  def play(name)
    Thread.new { `mpg123 #{mp3_path name} > /dev/null 2>&1` }
  end

  def process_special_command(input)
    if input == SpecialCommandCharacter
      print SpecialCommandCharacter
      special_command = get_char(true).to_sym rescue nil
      if self.class::SpecialCommandList.include? special_command
        send(special_command)
        print "\n"
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
      eval(keymap[input] || "")
    end
  end
  
end