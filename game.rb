class Game
  attr_reader :cards

  def initialize
    initialize_cards
  end

  def charge_cards(file_cards)
    @cards = Array.new
    lines = Array.new
    File.open(file_cards, 'r') do |f1|
      while line = f1.gets
        lines.push(line.chomp) unless  line == "\n"
      end
    end
    lines.each_slice(6){|team|
        @cards.push(team)
      }
  end

  def mix
    @cards = cards.shuffle
  end

  def initialize_cards
    raise NotImpelementedError.new
  end

  def rules
    raise NotImpelementedError.new
  end

  def get_awesome_cart
    card = get_card
    card[0] = "*#{card[0]}*"
    card.join("\n")
  end

  private

  def get_card
    @cards.shift();
  end
end