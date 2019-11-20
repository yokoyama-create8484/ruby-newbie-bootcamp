# Card object, Define suits & faces
class Card
  attr_accessor :ordinal
  attr_reader :suit, :face

  SUITS = %i[♣ ♦ ♥ ♠].freeze
  FACES = %i[2 3 4 5 6 7 8 9 10 J Q K A].freeze

  def initialize(str)
    @face, @suit = parse(str)
    @ordinal = FACES.index(@face)
  end

  private

  def parse(str)
    face = str.chop.to_sym
    suit = str[-1].to_sym
    raise ArgumentError, "invalid card: #{str}" \
      unless FACES.include?(face) && SUITS.include?(suit)

    [face, suit]
  end
end
