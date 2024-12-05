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

  end

  defp parse_rules(rules) do
    rules
    |> String.split()
  end
end

Day4.part1(test_rules, test_updates)
# Day4.part1(file_rules, file_updates)
