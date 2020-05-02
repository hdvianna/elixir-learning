defmodule Cards do

  def create_deck do
    # creates a list of strings (double-quotes)
    values = ["Ace", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "Jack", "Queen", "King"]
    suits = ["Spades", "Clubs", "Hearts", "Diamonds"]

    #List.flatten(
    #  #for is a function! =)
    #  for suit <- suits do
    #    for value <- values do
    #      "#{value} of #{suit}" #Similar to ECMA Script templates
    #    end
    #  end
    #)

    List.flatten(
      #Magic! Combines the lists!!!! 😱 😱 😱
      for suit <- suits, value <-values do
        "#{value} of #{suit}" #Similar to ECMA Script templates
      end
    )

  end

  def shuffle (deck) do
    Enum.shuffle(deck) #No need of importing (https://hexdocs.pm/elixir/Enum.html#content)
  end

  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  def deal(deck, hand_size) do
    Enum.split(deck, hand_size) #Returns a tuple
  end

end
