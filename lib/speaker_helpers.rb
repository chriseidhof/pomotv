module SpeakerHelpers
  def speaker_page(name)
    require 'middleman-blog/uri_templates'
    slug = Middleman::Blog::UriTemplates.safe_parameterize name
    "/speakers/#{slug}"
  end
end
