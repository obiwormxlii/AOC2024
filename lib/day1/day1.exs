file_input = File.read!("input1.txt")

test_input = """
3   4
4   3
2   5
1   3
3   9
3   3
"""


defmodule Day1 do

  def solve(input) do
    sort_input(input)
    |> Enum.map(&Enum.map(&1, fn x -> String.to_integer(x) end))
    |> Enum.map(&Enum.sort(&1))
    |> Enum.zip()
    |> Enum.map(&find_difference/1)
    |> Enum.sum()

  end

  defp sort_input(input) do
    list = String.split(input)

    left = Enum.take_every(list, 2)

    right =
        tl(list)
        |> Enum.take_every(2)

    [left, right]
  end

  defp find_difference({a,b}) do
    case {a,b} do
      {a, b} when a < b ->
        b-a
      {a, b} when b < a ->
        a-b
      _ ->
        0
    end
  end

end

solution = Day1.solve(file_input)
IO.inspect(solution)
