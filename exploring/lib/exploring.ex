defmodule Exploring do

  def newInc(x) do
    {
      x,
      fn ->
        newInc(x + 1)
      end
    }
  end

end
