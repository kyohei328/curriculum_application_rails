class Admin::ArticlesController < ApplicationController
  layout 'admin'

  before_action :set_article, only: %i[edit update destroy]
  before_action :update_article_params, only: %i[update]

  def index
    authorize(Article)

    @search_articles_form = SearchArticlesForm.new(search_params)
    @articles = @search_articles_form.search.order(id: :desc).page(params[:page]).per(25)
  end

  def new
    @article = Article.new
  end

  def create
    authorize(Article)

    @article = Article.new(article_params)
    @article.state = :draft

    if @article.save
      redirect_to edit_admin_article_path(@article.uuid)
    else
      render :new
    end
  end

  def edit
    authorize(@article)
  end

  def update
    authorize(@article)
        # binding.pry
    if @article.update(@ap)
      flash[:notice] = '更新しました'
      redirect_to edit_admin_article_path(@article.uuid)
    else
      render :edit
    end
  end

  def destroy
    authorize(@article)

    @article.destroy

    redirect_to admin_articles_path
  end

  private

  def article_params
    params.require(:article).permit(
      :title, :description, :slug, :state, :published_at, :eye_catch, :category_id, :author_id, tag_ids: []
    )
  end

  def search_params
    params[:q]&.permit(:title, :category_id)
  end

  def set_article
    @article = Article.find_by!(uuid: params[:uuid])
  end

  def update_article_params
    @ap = params.require(:article).permit(
      :title, :description, :slug, :state, :published_at, :eye_catch, :category_id, :author_id, tag_ids: []
    )
    # binding.pry
        if @ap[:state] == 'published' && @ap[:published_at].to_time >= Time.current
          @ap[:state] = 'publish_wait'
        elsif @ap[:state] == 'publish_wait' &&  @ap[:published_at].to_time <= Time.current
          @ap[:state] = 'published'
        end
  end
end
