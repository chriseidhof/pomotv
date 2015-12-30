require 'rubygems'
require 'middleman-gh-pages'
require 'dotenv/tasks'
require 'yt'
require 'yaml'


task :default => [:build, "lint:speakers", "lint:editions"]

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

  task :editions do
    videos = YAML.load_file('data/videos.yml')
    data_editions = YAML.load_file('data/editions.yml')
    data_events = YAML.load_file('data/events.yml')

    # TODO: this is duplicated from the video_helpers.rb
    editions = Hash.new
    data_editions.each do |metadata|
      editions["#{metadata["event"]} #{metadata["edition"]}"] = metadata
    end

    no_events = editions.values.reject { |metadata|
      data_events[metadata["event"]] != nil
    }
    unless no_events.empty?
      raise "Missing entries in data/events.yml for the following events: \n#{no_events.join(", ")}"
    end

    no_editions = videos.keys.reject { |edition_name|
      edition = editions[edition_name]
      edition && edition['url'] != nil && edition['date'] != nil
      # && edition['slug'] != nil
    }
    unless no_editions.empty?
      raise "Missing entries in data/editions.yml for the following editions: \n#{no_editions.join(", ")}"
    end
  end
end
