class SearchController < ApplicationController
  def search
    @results = Article.search(params[:search])

    render turbo_stream: turbo_stream.update('articles', partial: 'articles/articles',
                                                         locals: { articles: @results })
  end
end
