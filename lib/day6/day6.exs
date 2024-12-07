test_input = """
....#.....
.........#
..........
..#.......
.......#..
..........
.#..^.....
........#.
#.........
......#...
"""

file_input = File.read!("input6.txt")

defmodule Day6 do
  def part1(input) do
    map = input
    # |> IO.inspect()
    |> parse_input()

    map
    |> move_guard()
    |> Enum.concat()
    |> Enum.filter(& &1 == "X")
    |> Enum.count()
    |> IO.inspect()

  end

  defp parse_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.split(&1, "", trim: true))
  end

  defp find_guard(map) do
    map
    |> Enum.reduce_while(%{x: nil, y: 0},fn row, acc ->
      row
      |> Enum.find_index(fn col ->
        col in ["^", ">", "v", "<"]
      end)
      |> then(fn res ->
        if res == nil do
          {:cont, %{y: acc.y + 1, x: nil}}
        else
          {:halt, %{y: acc.y, x: res}}
        end
      end)
    end)
  end

  defp value_at(map, x, y) do
    map
    |> Enum.at(y)
    |> then(fn res -> if res == nil, do: nil, else: Enum.at(res, x) end)
  end

  defp get_vector(guard_coord, map) do
    map
    |> value_at(guard_coord.x, guard_coord.y)
    |> then(fn guard ->
      case guard do
        "^" ->
          {0, -1}
        ">" ->
          {1, 0}
        "v" ->
          {0, 1}
        "<" ->
          {-1, 0}
        end
      end
      )
    end

  defp rotate_vector(vector) do
    case vector do
      {0, -1} ->
        %{guard: ">", vector: {1, 0}}
      {1, 0} ->
        %{guard: "v", vector: {0, 1}}
      {0, 1} ->
        %{guard: "<", vector: {-1, 0}}
      {-1, 0} ->
        %{guard: "^", vector: {0, -1}}
    end
  end

  defp swap(map, coord, val) do
    y = map
    |> Enum.at(coord.y)
    |> List.replace_at(coord.x, val)

    List.replace_at(map, coord.y, y)
  end

  defp move_guard(map) do
    guard_coord = find_guard(map)
    vector = get_vector(guard_coord, map)
    next_val = value_at(map, guard_coord.x + elem(vector, 0), guard_coord.y + elem(vector, 1))

    case next_val do
      "#" ->
        vector = rotate_vector(vector)
        swap(map, guard_coord, vector.guard)
        |> move_guard()
      nil ->
        map
        |> swap(guard_coord, "X")
      _ ->
        guard = value_at(map, guard_coord.x, guard_coord.y)
        map
        |> swap(guard_coord, "X")
        |> swap(%{x: guard_coord.x + elem(vector, 0), y: guard_coord.y + elem(vector, 1)}, guard)
        |> move_guard()
    end
  end
end

Day6.part1(test_input)
# Day6.part1(file_input)
