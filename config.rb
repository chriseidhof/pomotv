require 'middleman-blog/uri_templates'
require 'middleman-search'

require "lib/video_helpers"
require "lib/speaker_helpers"
require "lib/tag_helpers"
helpers VideoHelpers
helpers SpeakerHelpers
helpers TagHelpers
include VideoHelpers
include SpeakerHelpers
include TagHelpers

config[:github_repo_url] = 'https://github.com/chriseidhof/pomotv'
config[:site_url] = 'http://www.pomo.tv/' # Used in atom feeds that need a full URL, avoid using otherwise 
config[:site_name] = 'www.pomo.tv'
config[:css_dir] = 'stylesheets'
config[:js_dir] = 'javascripts'
config[:images_dir] = 'images'

@app.data.editions.each do |metadata|
  name = "#{metadata[:event]} #{metadata[:edition]}"
  event = @app.data.events[metadata[:event]]
  safe_edition = safe_parameterize metadata[:edition]
  slug = "#{event[:slug]}/#{safe_edition}"
  metadata[:slug] = slug
  base_url = edition_url(metadata)
  html = "#{base_url}/index.html"
  feed = "#{base_url}/feed.xml"

  proxy html, "edition.html", :locals => { :name => name, :metadata => metadata, :videos => @app.data.videos[name], :atom_feed => feed}, :ignore => true, :search_title => "Event: #{name}"
  proxy feed, "feed.xml", :locals => { :name => name, :videos => @app.data.videos[name], :html_page => base_url}, :ignore => true
end

data.speakers.each do |name, metadata|
  base_url = speaker_page(name)
  html = "#{base_url}/index.html"
  feed = "#{base_url}/feed.xml"

  videos = @app.data.videos.map { |k,v| [k,v.select { |video| video.speakers.include? name }] }.select { |k, v| v.count > 0 }

  proxy html, "speaker.html", :locals => { :name => name, :speaker => metadata , :videos => videos, :atom_feed => feed}, :ignore => true, :search_title => "Speaker: #{name}"
  proxy feed, "feed.xml", :locals => { :name => name, :videos => videos.map { |c| c[1] }.flatten, :html_page => base_url}, :ignore => true
end

all_tags.each do |tag|
  base_url = "/tags/#{slug_for_tag(tag)}"
  html = "#{base_url}/index.html"
  feed = "#{base_url}/feed.xml"

  videos = videos_for_tag(tag)

  proxy html, "tag.html", :locals => { :video_tag => tag, :videos => videos, :atom_feed => feed}, :ignore => true, :search_title => "Tag: #{tag}"
  proxy feed, "feed.xml", :locals => { :name => tag, :videos => videos.map { |c| c[1] }.flatten, :html_page => base_url}, :ignore => true
end

@app.data.videos.map do |edition,videos|
  videos.map do |video|
    video["edition"] = edition
    page_url = "/events/#{video_id(video)}.html"
    proxy page_url, "video.html", :locals => { :video => video }, :ignore => true, :search_title => "Video: #{video.title}"
  end
end

activate :search do |search|
  search.resources = ['events/', 'tags/', 'speakers/']
  search.index_path = "search/index.json"
  search.fields = {
      search_title: {boost: 100, store: true, required: true},
      content: {boost: 50},
      url: {index: false, store: true}
  }
  # cache the index during development
  search.cache = true
end

