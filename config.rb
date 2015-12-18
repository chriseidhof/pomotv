require 'middleman-blog/uri_templates'

###
# Compass
###

# Change Compass configuration
# compass_config do |config|
#   config.output_style = :compact
# end

###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
# page "/path/to/file.html", :layout => false
#
# With alternative layout
# page "/path/to/file.html", :layout => :otherlayout
#
# A path which all have the same layout
# with_layout :admin do
#   page "/admin/*"
# end

# Proxy pages (https://middlemanapp.com/advanced/dynamic_pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", :locals => {
#  :which_fake_page => "Rendering a fake page with a local variable" }

###
# Helpers
###

# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes

# Reload the browser automatically whenever files change
# configure :development do
#   activate :livereload
# end

# Methods defined in the helpers block are available in templates
# helpers do
#   def some_helper
#     "Helping"
#   end
# end

require "source/lib/video_helpers"
require "source/lib/speaker_helpers"
require "source/lib/tag_helpers"
helpers VideoHelpers
helpers SpeakerHelpers
helpers TagHelpers

set :css_dir, 'stylesheets'

set :js_dir, 'javascripts'

set :images_dir, 'images'

data.events.each do |name, metadata|
  proxy "/events/#{metadata.slug}/index.html", "/event.html", :locals => { :name => name, :metadata => metadata , :videos => data.videos[name]}, :ignore => true
end

data.speakers.each do |name, metadata|
  videos = data.videos.map { |k,v| [k,v.select { |video| video.speakers.include? name }] }.select { |k, v| v.count > 0 }
  proxy(speaker_page(name) + "/index.html", "/speaker.html", :locals => { :name => name, :speaker => metadata , :videos => videos}, :ignore => true)
end

all_tags.each do |tag|
  videos = videos_for_tag(tag)
  slug = slug_for_tag(tag)
  proxy "/tags/#{slug}/index.html", "/tag.html", :locals => { :tag => tag, :videos => videos}, :ignore => true
end

# Build-specific configuration
configure :build do
  # For example, change the Compass output style for deployment
  # activate :minify_css

  # Minify Javascript on build
  # activate :minify_javascript

  # Enable cache buster
  # activate :asset_hash

  # Use relative URLs
  # activate :relative_assets

  # Or use a different image path
  # set :http_prefix, "/Content/images/"
end
