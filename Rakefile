require 'rubygems'
require 'middleman-gh-pages'
require 'dotenv/tasks'
require 'yt'

task :fetchyt, [:user] => :dotenv do |t, args|
  url = "https://www.youtube.com/user/#{args[:user]}/"
  channel = Yt::Channel.new url: url
  channel.videos.each do |video|
    puts "  - language: English"
    puts "    speakers: [TODO]"
    puts "    title: #{video.title}"
    puts "    tags: []"
    puts "    youtube: #{video.id}"
  end
end

task :lint_speakers do
  require 'yaml'
  videos = YAML.load_file('data/videos.yml')
  speakers = YAML.load_file('data/speakers.yml')
  all_speaker_names = videos.values.flatten.map { |video| video['speakers'] }.flatten.uniq
  no_entry = all_speaker_names.reject{ |s| speakers[s] }
  result = Hash.new
  no_entry.each do |s|
    result[s] = { "twitter" => "TODO" }
  end
  unless result.empty?
    STDERR.puts "Please add entries for the following speakers"
    puts result.to_yaml
  end
end
