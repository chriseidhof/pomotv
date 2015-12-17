module VideoHelpers
  def link_to_video(video)
    if video['direct-link']
      url = video['direct-link']
    elsif video.youtube
      url = "https://www.youtube.com/watch?v=#{video.youtube}"
    elsif video.vimeo
      url = "https://vimeo.com/#{video.vimeo}"
    end
    link_to(video.title, url)
  end

  def embed_video(video)
    width = 560
    height = 315
    if video.youtube
      url = "https://www.youtube.com/embed/#{video.youtube}"
    elsif video.vimeo
      url = "https://player.vimeo.com/video/#{video.vimeo}"
    end
    "<iframe width=\"#{width}\" height=\"#{height}\" src=\"#{url}\" frameborder=\"0\" allowfullscreen></iframe>"
  end
end
