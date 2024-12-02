file_input = File.read!("input2.txt")

test_input = """
7 6 4 2 1
1 2 7 8 9
9 7 6 2 1
1 3 2 4 5
8 6 4 4 1
1 3 6 7 9
"""

defmodule Day2 do
  def solve(input) do
    # IO.inspect(input)
    parse_input(input)
    |> Enum.map(&is_safe?/1)
    |> IO.inspect
    |> Enum.count(&(&1 == true))
    |> IO.inspect
  end

  defp parse_input(input) do
    String.split(input, "\n", trim: true)
    |> Enum.map(&parse_lines/1)
  end

  defp parse_lines(line) do
    line
    |> String.split(" ", trim: true)
    |> Enum.map(&String.to_integer/1)
  end

  defp is_safe?([first, second | tail]) do
    cond do
      first == second ->
        false
      second > first ->
        list = Enum.reverse([first] ++ [second] ++ tail)
        is_safe?(list, :reversed)
      true ->
        is_safe?([second] ++ tail, [safety_checker(first, second)])
    end
  end

  defp is_safe?([first, second | tail], :reversed) do
    cond do
      first == second ->
        false
      first < second ->
        false
      true ->
        is_safe?([second] ++ tail, [safety_checker(first, second)])
    end
  end

  defp is_safe?([first, second | tail], acc) do
    if tail == [] do
      res = Enum.all?([safety_checker(first, second)] ++ acc)
    else
      is_safe?([second] ++ tail, [safety_checker(first, second)] ++ acc)
    end
  end


  defp safety_checker(x, y) do
    val = x - y

    if val >= 1 and val <=3 do
      true
    else
      false
    end
  end

end

Day2.solve(file_input)
