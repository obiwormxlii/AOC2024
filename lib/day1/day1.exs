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
    number_lists = sort_input(input)
    |> Enum.map(&Enum.map(&1, fn x -> String.to_integer(x) end))

    part1(number_lists)
    part2(number_lists)

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

  defp part1(number_lists) do
    number_lists
    |> Enum.map(&Enum.sort/1)
    |> Enum.zip()
    |> Enum.map(&find_difference/1)
    |> Enum.sum()
    |> IO.inspect(label: "Part 1")

  end

  defp part2([list_a, list_b]) do
    list_a
    |> Enum.map(fn x -> %{x => Enum.reduce(list_b, 0, fn y, acc -> get_count(y,x,acc) end)} end)
    |> Enum.concat()
    |> Enum.map(&Tuple.product(&1))
    |> Enum.sum()
    |> IO.inspect(label: "Part 2")
  end

  defp get_count(testing, tester, acc) do
    if testing == tester do
      acc+1
    else
        acc
    end
  end

end

Day1.solve(test_input)
