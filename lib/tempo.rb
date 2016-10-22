module Sounds::Tempo
  def self.up
    increment_or_decrement(:up)
  end
  
  def self.down
    increment_or_decrement(:down)
  end

  def self.set
    puts "\n enter tempo followed by new line"
    new_tempo = gets.chomp
    if new_tempo.is_number?
      $tempo_bpm = new_tempo.to_f
      true
    else
      false
    end
  end

  def self.increment_or_decrement(type)
    puts "\n enter amount to change (#{type}) followed by new line"
    amt = gets.chomp
    if amt.is_number?
      if type == :up
        $tempo_bpm += amt.to_f
      else
        $tempo_bpm -= amt.to_f
      end
    else
      puts "invalid command"; return
    end
  end
end

