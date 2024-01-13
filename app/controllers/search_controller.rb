class SearchController < ApplicationController
  def search
    query = params[:search]

    @results = Article.ransack(title_cont: query).result

    # Check if there are results
    if @results.present?
      store_most_complete_query(query, request.remote_ip)
    end

    respond_to do |format|
      format.json { render json: @results }
    end
  end

  private

  def store_most_complete_query(query, user_ip)
    return if query.blank?
    existing_searches = Search.where(user_ip: user_ip).pluck(:query)
    
    # Use fuzzy matching to find the most similar existing query
    fuzzy = FuzzyMatch::FuzzyMatcher.new(existing_searches)
    most_similar_query = fuzzy.fuzzy_match(query)
    
    if most_similar_query.present?
      # If a more complete version exists, update the existing record
      Rails.logger.info "most_similar_query: #{most_similar_query}"
      Search.where(user_ip: user_ip, query: most_similar_query).update(query: query)
    else
      # If not, create a new record
      Search.create(user_ip: user_ip, query: query)
    end
  end
end
