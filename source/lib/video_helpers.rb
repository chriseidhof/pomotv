module VideoHelpers
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
      "<a href=\"https://www.youtube.com/watch?v=#{video.youtube}\" class=\"embed-video\" data-url=\"https://www.youtube.com/embed/#{video.youtube}?autoplay=1&autohide=1\" data-thumbnail=\"http://i.ytimg.com/vi/#{video.youtube}/sddefault.jpg\"></a>"
    else
      if video.vimeo
        url = "https://player.vimeo.com/video/#{video.vimeo}"
      elsif video.wwdc
        url = "https://developer.apple.com/videos/play/#{video.wwdc}"
      end
      "<iframe src=\"#{url}\" frameborder=\"0\" allowfullscreen></iframe>"
    end
  end
end
