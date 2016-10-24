require_relative "./arpeggiator_scales.rb"

module Sounds::Arpeggiator
  
  SavedScales = {}

  Scales = Sounds::ArpeggiatorScales

  def self.get_scale(scale_id, *args)
    Scales.send(scale_id, *args) || []
  end

  def self.save_scale(sound_name, scale_id=:default, *scale_args)
    note_deltas = round_deltas_to_2(get_scale(scale_id, *scale_args))
    orig_path = "./mp3/#{sound_name}.mp3"
    sound_name = sound_name.gsub("/", "_")
    dest_folder = "./mp3/arpeggios/#{sound_name}"
    `mkdir -p #{dest_folder}` unless Dir.exists? dest_folder
    note_deltas.each do |note_delta|
      note_path = get_note_path(sound_name, note_delta)
      unless File.exists? note_path
        `ruby ./audio_manip_scripts/pitch.rb #{orig_path} #{note_path} #{note_delta}`
      end
    end
  end

  def self.play_scale(cache_id, sound_name, scale_id=:default, *scale_args, &delay_blk)
    save_scale(sound_name, scale_id, *scale_args) unless SavedScales[cache_id]
    SavedScales[cache_id] = true
    note_deltas = round_deltas_to_2(get_scale(scale_id, *scale_args))
    note_deltas.each_with_index do |delta, idx|
      play_note(sound_name, delta)
      delay_blk ? sleep(delay_blk.call(delta, idx)) : sleep(60.0 / $tempo_bpm)
    end
  end

  def self.play_note(sound_name, note_delta)
    sound_name = sound_name.gsub("/", "_")
    note_path = get_note_path(sound_name, note_delta)
    Thread.new { Sounds::Base.play_file_with_mpg123 note_path }
  end

  def self.get_note_path(sound_name, note_delta)
    "./mp3/arpeggios/#{sound_name}/#{sound_name}-#{note_delta.to_s.gsub(".", "-")}.mp3"
  end

  def self.round_deltas_to_2(deltas)
    deltas.map { |delta| delta.round(2) }
  end

end


