test_input = """
xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))
"""
file_input = File.read!("./input3.txt")

defmodule Day3 do
  def part1(input) do
    Regex.scan(~r/mul\(\d+,\d+\)/, input)
    |> Enum.concat()
    |> Enum.map(
      &String.replace_prefix(&1, "mul(", "")
      |> String.replace_suffix( ")", "")
      |> String.replace( ",", " ")
      |> String.split(" ", trim: true)
      |> Enum.map(fn x -> String.to_integer(x) end)
      |> Enum.product()
      )
    |> Enum.sum()
    |> IO.inspect()
  end
end

Day3.part1(file_input)
