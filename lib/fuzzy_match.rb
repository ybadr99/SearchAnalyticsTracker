module FuzzyMatch
    class FuzzyMatcher
      def initialize(collection, options = {})
        @collection = collection
        @attribute = options[:read]
      end
      def calculate_levenshtein_distance(str1, str2)
        matrix = []
        (0..str1.length).each do |i|
          matrix[i] = [i]
        end
  
        (0..str2.length).each do |j|
          matrix[0][j] = j
        end
  
        (1..str1.length).each do |i|
          (1..str2.length).each do |j|
            cost = (str1[i - 1] == str2[j - 1]) ? 0 : 1
            matrix[i][j] = [
              matrix[i - 1][j] + 1,           # deletion
              matrix[i][j - 1] + 1,           # insertion
              matrix[i - 1][j - 1] + cost     # substitution
            ].min
          end
        end
  
        matrix[str1.length][str2.length]
      end
  
      def fuzzy_match(query, threshold = 4)
        query = query.downcase
        best_match = nil
        min_distance = threshold + 1
  
        @collection.each do |item|
          value = @attribute ? item.send(@attribute).to_s.downcase : item.to_s.downcase
          distance = calculate_levenshtein_distance(query, value)
  
          if distance <= threshold && distance < min_distance
            min_distance = distance
            best_match = item
          end
        end
  
        best_match
      end
    end
end