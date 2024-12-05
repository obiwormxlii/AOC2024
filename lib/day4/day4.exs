test_rules = """
47|53
97|13
97|61
97|47
75|29
61|13
75|53
29|13
97|29
53|29
61|53
97|53
61|29
47|13
75|47
97|75
47|61
75|61
47|29
75|13
53|13
"""

test_updates = """
75,47,61,53,29
97,61,53,29,13
75,29,13
75,97,47,61,53
61,13,29
97,13,75,29,47
"""

file_rules = File.read!("input4a.txt")
file_updates = File.read!("input4b.txt")


defmodule Day4 do
  def part1(rules, updates) do
    rules = parse_input(rules, "|")
    updates = parse_input(updates, ",")

    Enum.filter(updates, &valid_update?(&1, rules))
    |>Enum.map(&get_middle(&1))
    |> Enum.sum()
    |> IO.inspect()
  end

  def part2(rules, updates) do
    rules = parse_input(rules, "|")
    updates = parse_input(updates, ",")

    Enum.filter(updates, fn x -> not valid_update?(x, rules) end)
    |> Enum.map(&Enum.reduce(&1, [], fn x, acc -> sort(x, acc, rules) end))
    |>Enum.map(&get_middle(&1))
    |> Enum.sum()
    |> IO.inspect()
  end

  defp parse_input(input, char) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.split(&1, char)
      |> Enum.map(fn x-> String.to_integer(x) end)
      )
  end

  defp valid_update?(update, rules) do
    update
    |> Enum.reduce(%{list: [], tests: []}, fn val, acc ->

      %{list: acc.list ++ [val], tests: acc.tests ++ [rule_test(val, acc.list, rules)]}
    end)
    |> Map.get(:tests)
    |> Enum.all?(fn x -> x == false end)
  end

  defp rule_test(val, list, rules) do
      Enum.filter(rules, fn [x,_y] -> x == val end)
      |> Enum.map(&Enum.member?(list, Enum.at(&1, 1)))
      |> Enum.any?(fn x -> x == true end)
  end

  defp get_middle(list) do
    middle_index = (length(list) - 1) |> div(2)
    Enum.at(list, middle_index)
  end


  defp sort(val, acc, rules) do
    test = rule_test(val, acc, rules)
    if test do
      sort(val, acc, List.pop_at(acc, -1), rules)
    else
      acc ++ [val]
    end
  end

  defp sort(val, acc, pop, rules) do
    popped_list = Enum.at(Tuple.to_list(pop), 1)
    cond do
      length(popped_list) == 0 ->
        [val] ++ acc

      rule_test(val, popped_list, rules) ->
        sort(val, acc, List.pop_at(popped_list, -1), rules)

      true ->
        index = length(popped_list)
        List.insert_at(acc, index, val)
    end
  end
end


# Day4.part2(test_rules, test_updates)
Day4.part2(file_rules, file_updates)
