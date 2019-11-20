require 'minitest/autorun'
require 'minitest/reporters'

# Choose Output Method
# Minitest::Reporters.use! Minitest::Reporters::HtmlReporter.new
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require_relative '../lib/hand.rb'

class HandTest < Minitest::Test
  def test_high_card
    hand = Hand.new(['2♥', '5♥', '7♦', '8♣', '9♠'])
    assert_equal 'high-card', hand.rank
  end

  def test_one_pair
    hand = Hand.new(['4♥', '4♠', 'K♠', '2♦', '10♠'])
    assert_equal 'one-pair', hand.rank
  end

  def test_two_pair
    hand = Hand.new(['2♥', '7♥', '2♦', '3♣', '3♦'])
    assert_equal 'two-pair', hand.rank
  end

  def test_three_of_a_kind
    hand = Hand.new(['2♥', '2♦', '2♣', 'K♣', 'Q♦'])
    assert_equal 'three-of-a-kind', hand.rank
  end

  def test_straight
    hand = Hand.new(['A♥', '2♦', '3♣', '4♣', '5♦'])
    assert_equal 'straight', hand.rank
  end

  def test_flush
    hand = Hand.new(['Q♣', '10♣', '7♣', '6♣', '3♣'])
    assert_equal 'flush', hand.rank
  end

  def test_full_house
    hand = Hand.new(['2♥', '3♥', '2♦', '3♣', '3♦'])
    assert_equal 'full-house', hand.rank
  end

  def test_four_of_a_kind
    hand = Hand.new(['3♠', '3♥', '2♦', '3♣', '3♦'])
    assert_equal 'four-of-a-kind', hand.rank
  end

  def test_straight_flush
    hand = Hand.new(['A♥', '2♥', '3♥', '4♥', '5♥'])
    assert_equal 'straight-flush', hand.rank
  end

  def test_royal_straight_flush
    hand = Hand.new(['10♥', 'J♥', 'Q♥', 'K♥', 'A♥'])
    assert_equal 'royal-straight-flush', hand.rank
  end

  def test_invalid_face
    # エラーが発生することを検証
    e = assert_raises ArgumentError do
      Hand.new(['0♥', 'J♥', 'Q♥', 'K♥', 'A♥'])
    end
    # エラーメッセージを検証
    assert_equal 'invalid card: 0♥', e.message
  end

  def test_invalid_suit
    # エラーが発生することを検証
    e = assert_raises ArgumentError do
      Hand.new(['1¥', 'J♥', 'Q♥', 'K♥', 'A♥'])
    end
    # エラーメッセージを検証
    assert_equal 'invalid card: 1¥', e.message
  end
end
