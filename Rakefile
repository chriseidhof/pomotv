require 'rubygems'
require 'middleman-gh-pages'
require 'dotenv/tasks'
require 'yt'
require 'yaml'


task :default => [:build, "lint:speakers", "lint:events"]

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

task :fetchwwdc, [:year] => :dotenv do |t, args|
  yaml_content = open("https://raw.githubusercontent.com/ASCIIwwdc/wwdc-session-transcripts/master/#{args[:year]}/_sessions.yml"){|f| f.read}
  yaml_data = YAML::load(yaml_content) 
  
  # puts yaml_data.inspect
  yaml_data.each do |id, video|
    puts "  - language: English"
    puts "    speakers: [TODO]"
    puts "    title: \"#{video[:title]}\""
    puts "    description: \"#{video[:description]}\""
    puts "    tags: [#{video[:track]}]".downcase
    puts "    wwdc: \"wwdc#{args[:year]}-#{id}\""
    puts "    direct-link: \"https://developer.apple.com/videos/play/wwdc#{args[:year]}-#{id}\""
  end
end

namespace :lint do
  task :speakers do
    videos = YAML.load_file('data/videos.yml')
    speakers = YAML.load_file('data/speakers.yml')
    all_speaker_names = videos.values.flatten.map { |video| video['speakers'] }.flatten.uniq
    no_entry = all_speaker_names.reject{ |s| speakers[s] }
    result = Hash.new
    no_entry.each do |s|
      result[s] = { "twitter" => "TODO" }
    end
    unless result.empty?
      STDERR.puts "Please add entries for the following speakers:"
      puts result.to_yaml
      raise
    end
  end

  task :events do
    videos = YAML.load_file('data/videos.yml')
    events = YAML.load_file('data/events.yml')
    no_events = videos.keys.reject { |event_name|
      event = events[event_name]
      event && event['url'] != nil && event['date'] != nil && event['slug'] != nil
    }
    unless no_events.empty?
      raise "Missing entries in data/events.yml for the following events: \n#{no_events.join(", ")}"
    end
  end
end
