class Admin::Articles::PublishesController < ApplicationController
  layout 'admin'

  before_action :set_article
  before_action :set_state

  def update
    if !@article.published_at?
      @article.published_at = Time.current
      @article_state = :published
    else
      @article.assign_publish_state
    end

    if @article.valid?
      Article.transaction do
        @article.body = @article.build_body(self)
        @article.save!
      end
      flash[:notice] = @article.massage_on_published
      redirect_to edit_admin_article_path(@article.uuid)
    else
      flash.now[:alert] = 'エラーがあります。確認してください。'

      @article.state = @article.state_was if @article.state_changed?
      render 'admin/articles/edit'
    end
  end

  private

  def set_article
    @article = Article.find_by!(uuid: params[:article_uuid])
  end

  def set_state
    if @article.published_at.nil?
      @article.published_at = Time.current
      @article.state = :published
    elsif @article.published_at >= Time.current
      @article.state = :publish_wait
    else
      @article.state = :published
    end
  end
end
