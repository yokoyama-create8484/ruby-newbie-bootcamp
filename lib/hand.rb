require_relative 'card.rb'

# Poker Hand Evaluation
class Hand
  attr_reader :cards, :rank

  WHEEL_FACES = %i[2 3 4 5 A].freeze

  def initialize(draw_cards)
    @cards = draw_cards.map { |str| Card.new(str) }
    grouped = @cards.group_by(&:face).values
    @face_pattern = grouped.map(&:size).sort
    @rank = categorize
  end

  private

  def one_suit?
    @cards.map(&:suit).uniq.size == 1
  end

  def straight?
    sort.each_cons(2).all? { |c1, c2| c2.ordinal - c1.ordinal == 1 }
  end

  def royal?
    # a2345の時はaは-1として扱われるため、a=12は10jqkaの時のみ
    @cards.map(&:ordinal).max == 12
  end

  def sort
    if @cards.sort_by(&:ordinal).map(&:face) == WHEEL_FACES
      @cards.detect { |c| c.face == :A }.ordinal = -1
    end
    @cards.sort_by(&:ordinal)
  end

  def loose
    if straight?
      if one_suit?
        royal? ? 'royal-straight-flush' : 'straight-flush'
      else
        'straight'
      end
    else
      one_suit? ? 'flush' : 'high-card'
    end
  end

  def categorize
    case @face_pattern
    when [1, 1, 1, 1, 1]  then loose
    when [1, 1, 1, 2]     then 'one-pair'
    when [1, 2, 2]        then 'two-pair'
    when [1, 1, 3]        then 'three-of-a-kind'
    when [2, 3]           then 'full-house'
    when [1, 4]           then 'four-of-a-kind'
    when [5]              then 'five-of-a-kind'
    end
  end
end
