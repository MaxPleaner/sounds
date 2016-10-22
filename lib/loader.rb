module Sounds::Loader

  Mp3Folder = ENV["Mp3Folder"] || "./mp3"

  Mp3Files = Dir.glob Mp3Folder

  def mp3_path(name)
    "#{Mp3Folder}/#{name}.mp3"
  end

  def get_sound_paths
    Mp3Files.reduce({}) do |sound_paths, path|
      sound_paths.merge(path.file_identifier => path)
    end
  end

end
