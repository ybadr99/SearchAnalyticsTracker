# frozen_string_literal: true

require_relative '../lib/fuzzy_match'

RSpec.describe FuzzyMatch::FuzzyMatcher do
  let(:collection) do
    [
      { id: 1, name: 'Apple' },
      { id: 2, name: 'Banana' },
      { id: 3, name: 'Orange' },
      { id: 4, name: 'Grapes' }
    ]
  end

  context 'when initializing' do
    it 'should set the collection and attribute' do
      fuzzy_matcher = FuzzyMatch::FuzzyMatcher.new(collection, read: :name)

      expect(fuzzy_matcher.instance_variable_get(:@collection)).to eq(collection)
      expect(fuzzy_matcher.instance_variable_get(:@attribute)).to eq(:name)
    end
  end

  context 'when calculating levenshtein similarity' do
    it 'should calculate the correct levenshtein similarity' do
      fuzzy_matcher = FuzzyMatch::FuzzyMatcher.new([]) # Initialize with an empty collection

      similarity = fuzzy_matcher.calculate_levenshtein_distance('apple', 'aple')

      expect(similarity).to be_within(0.01).of(0.75)
    end
  end

  context 'when performing fuzzy match' do
    it 'should return the best match' do
      fuzzy_matcher = FuzzyMatch::FuzzyMatcher.new(collection, read: :name)

      result = fuzzy_matcher.fuzzy_match('aple')

      expect(result[:name]).to eq('Apple')
    end

    it 'should consider the threshold for similarity' do
      fuzzy_matcher = FuzzyMatch::FuzzyMatcher.new(collection, read: :name)

      result = fuzzy_matcher.fuzzy_match('aple', 0.9)

      expect(result).to be_nil
    end
  end
end
