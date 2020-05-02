defmodule Cards do
  def create_deck do
    # creates a list of strings (double-quotes)
    values = [
      "Ace",
      "Two",
      "Three",
      "Four",
      "Five",
      "Six",
      "Seven",
      "Eight",
      "Nine",
      "Ten",
      "Jack",
      "Queen",
      "King"
    ]

    suits = ["Spades", "Clubs", "Hearts", "Diamonds"]

    # List.flatten(
    #  #for is a function! =)
    #  for suit <- suits do
    #    for value <- values do
    #      "#{value} of #{suit}" #Similar to ECMA Script templates
    #    end
    #  end
    # )

    List.flatten(
      # Magic! Combines the lists!!!! 😱 😱 😱
      for suit <- suits, value <- values do
        # Similar to ECMA Script templates
        "#{value} of #{suit}"
      end
    )
  end

  def shuffle(deck) do
    # No need of importing it is standard (https://hexdocs.pm/elixir/Enum.html#content)
    Enum.shuffle(deck)
  end

  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  def deal(deck, hand_size) do
    # Returns a tuple
    Enum.split(deck, hand_size)
  end

  def save(deck, filename) do
    # :erlang átomo para funções nativas do erlang
    # serializa a variável para binário
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  def load(filename) do
    # {result, data} = File.read(filename)
    # Last case statement line will return the result
    # case result do
    #  :ok -> :erlang.binary_to_term data #Don't use parenthesis
    #  :error -> []
    # end

    # Last matched case statement line will return the result
    # Will use pattern matching of File.read(filename) in the case statements! 😱
    case File.read(filename) do
      # Don't use parenthesis
      {:ok, data} -> :erlang.binary_to_term(data)
      # use _(underscore) in front of the variable name to ignore the warning
      {:error, _reason} -> []
    end
  end

  def create_hand(hand_size) do
    # Traditional, without pipes ...
    # deck = Cards.create_deck()
    # deck = Cards.shuffle(deck)
    # {hand, _remainder} = Cards.deal(deck, hand_size)
    # hand

    Cards.create_deck()
    |> shuffle
    |> deal(hand_size)
  end
end
