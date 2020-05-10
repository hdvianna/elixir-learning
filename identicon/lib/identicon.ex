defmodule Identicon do
  def gen_and_save(input, path) do
    File.write(
      path,
      input
      |> gen
    )
  end

  def gen(input) do
    input
    |> hash_input
    |> pick_color
    |> build_grid
    |> build_pixel_map
    |> draw_image
  end

  def hash_input(input) do
    %Identicon.Image{
      hex:
        :crypto.hash(:md5, input)
        |> :binary.bin_to_list()
    }
  end

  # Using pattern matching for extracting color values
  def pick_color(%Identicon.Image{hex: [r, g, b | _tail]} = image) do
    # Updating the structure
    %Identicon.Image{image | color: {r, g, b}}
  end

  def build_grid(%Identicon.Image{hex: hex} = image) do
    %Identicon.Image{
      image
      | grid:
          Enum.chunk_every(hex, 3)
          |> Enum.take(5)
          |> Enum.map(&mirror_row/1)
          |> List.flatten()
          |> Enum.with_index()
          |> filter_odd_squares
    }
  end

  def mirror_row(row) do
    [first, second, _item] = row
    row ++ [second, first]
  end

  def filter_odd_squares(grid) do
    Enum.filter(grid, fn {code, _index} ->
      rem(code, 2) == 0
    end)
  end

  def build_pixel_map(%Identicon.Image{grid: grid} = image) do
    pixel_map =
      Enum.map(grid, fn {_value, index} ->
        x1 = rem(index, 5) * 50
        y1 = div(index, 5) * 50
        {{x1, y1}, {x1 + 50, y1 + 50}}
      end)

    %Identicon.Image{image | pixel_map: pixel_map}
  end

  def draw_image(%Identicon.Image{color: color, pixel_map: pixel_map}) do
    image = :egd.create(250, 250)
    fill = :egd.color(color)

    Enum.each(pixel_map, fn {x, y} ->
      :egd.filledRectangle(image, x, y, fill)
    end)

    :egd.render(image)
  end
end
