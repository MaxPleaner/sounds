module Sounds::Base

  KeymapPath = ENV["KeymapPath"] || "keymap.yml"
  
  SpecialCommandCharacter = ENV["SpecialCommandCharacter"] || "/"

  def get_char(should_print=false)
    input = STDIN.getch
    exit(1) if input == "\u0003"
    print(input) if should_print
    input
  end

  def process_special_command(input)
    if input == SpecialCommandCharacter
      special_command = get_char(true).to_sym rescue nil
      if SpecialCommandList.include? special_command
        send(special_command)
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
      Thread.new { eval keymap[input] || "" }
    end
  end
  
end