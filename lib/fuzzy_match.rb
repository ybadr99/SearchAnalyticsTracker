module FuzzyMatch
  class FuzzyMatcher
    def initialize(collection)
      @collection = collection
    end

    # calculate similarity and bigram scores 
    def calculate_levenshtein_distance(str1, str2)
      bigrams1 = str1.downcase.each_char.each_cons(2).map(&:join)
      bigrams2 = str2.downcase.each_char.each_cons(2).map(&:join)
      #  intersection of the two bigram arrays
      common_bigrams = bigrams1 & bigrams2
      # union of the two bigram arrays
      total_bigrams = bigrams1 | bigrams2

      common_bigrams.length.to_f / total_bigrams.length
    end

    def fuzzy_match(query)
      query = query.downcase
      best_match = nil
      max_similarity = 0

      @collection.each do |item|
        value = item.to_s.downcase

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
