module Sounds::Loader

  Mp3Folder = ENV["Mp3Folder"] || "./mp3"

  Mp3Files = Dir.glob Mp3Folder

  def mp3_path(name)
    "#{Mp3Folder}/#{name}.mp3"
  end

  def play(name)
    `mpg123 #{mp3_path name} > /dev/null 2>&1`
  end

  def file_identifier(path)
    # i.e. gets 'kick' from '/my/path/kick.mp3'
    File.basename path, ".*"
  end

  def get_sound_paths
    Mp3Files.reduce({}) do |sound_paths, path|
      sound_paths.merge(file_identifier(path) => path)
    end
  end

end
