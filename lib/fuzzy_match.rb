# frozen_string_literal: true

module FuzzyMatch
  class FuzzyMatcher
    def initialize(collection, options = {})
      @collection = collection
      @attribute = options[:read]
    end

    def calculate_levenshtein_distance(str1, str2)
      bigrams1 = str1.downcase.each_char.each_cons(2).map(&:join)
      bigrams2 = str2.downcase.each_char.each_cons(2).map(&:join)

      common_bigrams = (bigrams1 & bigrams2).uniq
      total_bigrams = (bigrams1 | bigrams2).uniq

      common_bigrams.length.to_f / total_bigrams.length
    end

    def fuzzy_match(query, threshold = 0.3)
      query = query.downcase
      best_match = nil
      max_similarity = threshold

      @collection.each do |item|
        value = @attribute ? item[@attribute].to_s.downcase : item.to_s.downcase

        similarity = calculate_levenshtein_distance(value, query)

        if similarity > max_similarity
          max_similarity = similarity
          best_match = item
        end
      end

      best_match
    end
  end
end
