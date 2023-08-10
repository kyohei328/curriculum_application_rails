module ArticleBlockDecorator
  def box_header_icon
    if sentence?
      '<i class="fa fa-edit"></i>'.html_safe
    elsif medium?
      '<i class="fa fa-image"></i>'.html_safe
    elsif embed?
      # if blockable.embed_type == 'youtube'
      #   '<i class="fa fa-youtube-play"></i>'.html_safe
      # elsif blockable.embed_type == 'twitter'
      #   '<i class="fa fa-twitter"></i>'.html_safe
      # end
      blockable.embed_type == 'youtube' ? '<i class="fa fa-youtube-play"></i>'.html_safe : '<i class="fa fa-twitter"></i>'.html_safe
    end
  end

  def box_title
    if sentence?
      '文章'
    elsif medium?
      'メディア'
    elsif embed?
      '埋め込み'
    end
  end
end
