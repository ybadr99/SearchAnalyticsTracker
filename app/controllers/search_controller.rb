class SearchController < ApplicationController
  def search
    query = params[:search]
    
    @results = Article.ransack(title_cont: query).result

    # Check if there are results and the article title matches the query
    if @results.present? && @results.any? { |article| article.title.downcase == query.downcase }
      Search.find_or_create_by(query: query)
    end

    respond_to do |format|
      format.json { render json: @results }
    end
  end
end
