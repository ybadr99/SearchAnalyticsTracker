class SearchController < ApplicationController
  def search
    @results = Article.search(params[:search])

    @results = Article.search('*') if params[:search].blank?

    respond_to do |format|
      # format.turbo_stream do
      #   render turbo_stream: turbo_stream.update('articles', partial: 'articles/articles',
      #                                                        locals: { articles: @results })
      # end
      format.json { render json: @results } # JSON response
    end
  end
end
