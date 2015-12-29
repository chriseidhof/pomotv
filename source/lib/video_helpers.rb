module VideoHelpers
  include Middleman::Blog::UriTemplates

  def video_id(video)
    template = uri_template "{edition}-{speakers}-{title}"
    safe_edition = data.editions[video.edition].slug
    safe_speakers = safe_parameterize video.speakers.sort.join(" ")
    # Strip emoji and question marks from the titles
    safe_title = safe_parameterize video.title.gsub(/[\?\u{1f300}-\u{1f5ff}\u{1f600}-\u{1f64f}]/, '-')
    apply_uri_template template, {edition: safe_edition, speakers: safe_speakers, title: safe_title}
  end

  def video_url(video)
    if video.wwdc
      "https://developer.apple.com/videos/play/#{video.wwdc}"
    elsif video['direct-link']
      video['direct-link']
    elsif video.youtube
      "https://www.youtube.com/watch?v=#{video.youtube}"
    elsif video.vimeo
      "https://vimeo.com/#{video.vimeo}"
    end
  end

  def link_to_video(video)
    link_to(video.title, video_url(video))
  end

  def embed_video(video)
    if video.youtube
      url = "https://www.youtube.com/embed/#{video.youtube}"
    elsif video.vimeo
      url = "https://player.vimeo.com/video/#{video.vimeo}"
    elsif video.wwdc
      url = "https://developer.apple.com/videos/play/#{video.wwdc}"
    end
    "<iframe src=\"#{url}\" frameborder=\"0\" allowfullscreen></iframe>"
  end
end
