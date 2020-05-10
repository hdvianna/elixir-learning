defmodule CardsTest do
  use ExUnit.Case
  doctest Cards

  test "creates a deck" do
    deck = Cards.create_deck()
    size = length(deck)
    assert size === 52
  end
end
