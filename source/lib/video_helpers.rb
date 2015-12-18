module VideoHelpers
  def video_url(video)
    if video['direct-link']
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
    end
    "<iframe src=\"#{url}\" frameborder=\"0\" allowfullscreen></iframe>"
  end
end
