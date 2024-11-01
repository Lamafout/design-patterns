require 'minitest/autorun'
require './array_processor.rb'

class ArrayProcessorTests < Minitest::Test
    attr_reader :processor

    def setup
        self.processor = Array_processor.new([12, -4, 0, 49, -97])
    end

    def test_all?
        assert processor.all? { |x| x > -100 }
        refute processor.all? { |x| x > 0 } 
    end

    def test_flat_map
        assert_equal [24, -8, 0, 98, -194], processor.flat_map{ |x| x * 2 }
        assert_equal ['12', '-4', '0', '49', '-97'], processor.flat_map { |x| x.to_s }
    end

    def test_one?
        refute processor.one? { |x| x == 3 } 
        refute processor.one? { |x| x == 10 }
        refute processor.one? { |x| x > 1 } 
    end

    def test_inject
        assert_equal -40, processor.inject { |sum, x| sum + x }
        assert_equal -50, processor.inject(-10) { |sum, x| sum + x }
    end

    def test_min_by
        assert_equal 0, processor.min_by(&:abs)
        assert_equal 1, Array_processor.new([1, 1, 1]).min_by { |x| x * 2 }
    end

    def test_find
        assert_equal 12, processor.find { |x| x > 0 } 
        assert_nil processor.find { |x| x == 10 } 
    end

    private
    attr_writer :processor
end
