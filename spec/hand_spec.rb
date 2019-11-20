require_relative '../lib/hand.rb'

RSpec.describe 'ポーカーの役判定プログラム（正常系1）' do
  it 'ハイカード' do
    hand = Hand.new(['2♥', '5♥', '7♦', '8♣', '9♠'])
    expect(hand.rank).to eq 'high-card'
  end

  it 'ワンペア' do
    hand = Hand.new(['4♥', '4♠', 'K♠', '2♦', '10♠'])
    expect(hand.rank).to eq 'one-pair'
  end

  it 'ツーペア' do
    hand = Hand.new(['2♥', '7♥', '2♦', '3♣', '3♦'])
    expect(hand.rank).to eq 'two-pair'
  end

  it 'スリーカード' do
    hand = Hand.new(['2♥', '2♦', '2♣', 'K♣', 'Q♦'])
    expect(hand.rank).to eq 'three-of-a-kind'
  end

  it 'フルハウス' do
    hand = Hand.new(['2♥', '3♥', '2♦', '3♣', '3♦'])
    expect(hand.rank).to eq 'full-house'
  end

  it 'フォーカード' do
    hand = Hand.new(['3♠', '3♥', '2♦', '3♣', '3♦'])
    expect(hand.rank).to eq 'four-of-a-kind'
  end
end

RSpec.describe 'ポーカーの役判定プログラム（正常系2）' do
  it 'ストレート' do
    hand = Hand.new(['A♥', '2♦', '3♣', '4♣', '5♦'])
    expect(hand.rank).to eq 'straight'
  end

  it 'フラッシュ' do
    hand = Hand.new(['Q♣', '10♣', '7♣', '6♣', '3♣'])
    expect(hand.rank).to eq 'flush'
  end

  it 'ストレートフラッシュ' do
    hand = Hand.new(['A♥', '2♥', '3♥', '4♥', '5♥'])
    expect(hand.rank).to eq 'straight-flush'
  end

  it 'ロイヤルストレートフラッシュ' do
    hand = Hand.new(['10♥', 'J♥', 'Q♥', 'K♥', 'A♥'])
    expect(hand.rank).to eq 'royal-straight-flush'
  end
end

RSpec.describe 'ポーカーの役判定プログラム（異常系）' do
  it '不正なカード、ナンバーテスト' do
    expect do
      Hand.new(['0♥', 'J♥', 'Q♥', 'K♥', 'A♥'])
    end.to raise_error(ArgumentError, 'invalid card: 0♥')
  end

  it '不正なカード、スートテスト♠♥♦♣以外' do
    expect do
      Hand.new(['1¥', 'J♥', 'Q♥', 'K♥', 'A♥'])
    end.to raise_error(ArgumentError, 'invalid card: 1¥')
  end
end
