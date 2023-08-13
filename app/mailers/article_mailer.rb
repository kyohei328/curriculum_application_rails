class ArticleMailer < ApplicationMailer
  def report_summary
    @article_published_count = Article.where(state: 'published').count
    @article_published_yesterday = Article.where(published_at: 1.day.ago.all_day, state: 'published')
    mail(to: 'admin@example.com', subject: '公開済記事の集計結果')
  end
end
