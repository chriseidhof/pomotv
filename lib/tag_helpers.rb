module TagHelpers
  def slug_for_tag(tag)
    Middleman::Blog::UriTemplates.safe_parameterize tag
  end
  def videos_for_tag(tag)
    data.videos.to_a.map { |edition, videos|
      [edition, videos.select { |video|
        tags = video.tags || []
        tags.map(&:downcase).include? tag.downcase
      }]
    }.select { |key,value| value.count > 0 }
  end

  def all_tags
    data.videos.values.flatten.map(&:tags).flatten.compact.uniq.sort
  end
end
