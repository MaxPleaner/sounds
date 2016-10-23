module Sounds::Effects
  def stagger(sound, opts)
    eighth_note_rest_time = 60.0 / $tempo_bpm
    beat_type = opts[:beat_type] || 64.0
    custom_rest_time = eighth_note_rest_time / (beat_type / 8.0)
    (opts[:beats] || 4).times do
      play sound
      sleep custom_rest_time
    end
  end
end
