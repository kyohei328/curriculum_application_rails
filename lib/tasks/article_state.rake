namespace :article_state do
    desc 'update_article_state'
    task :update_article_state => :environment do
        @articles = Article.all
        @articles.each do |article|
            if Time.current >= article.published_at
                article.state = 'published'
                article.save
            end
        end
    end
end