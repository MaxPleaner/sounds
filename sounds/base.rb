module Sounds::Base
  KeymapPath = ENV["KeymapPath"] || "keymap.yml"
  
  def loop_input
    keymap = YAML.load File.read KeymapPath
    loop do
      input = STDIN.getch
      exit(1) if input == "\u0003"
      Thread.new { eval keymap[input] || "" }
    end
  end
  
end