module Sounds::Effects
  def stagger(name, loops=20, interval=0.05)
    loops.times do
      Thread.new { play name }
      sleep interval
    end
  end
end