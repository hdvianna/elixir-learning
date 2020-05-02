defmodule ExploringTest do
  use ExUnit.Case
  doctest Exploring

  test "greets the world" do
    assert Exploring.hello() == :world
  end
end
