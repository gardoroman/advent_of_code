defmodule Year2023.CubeGame do

  @moduledoc """
  Take input like the following:
   "Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green"
  """

  @game_counts %{
    "red" => 12,
    "green" => 13,
    "blue" => 14
  }

  @name_captures ~r/(?<num>\d+)\s(?<color>red|blue|green)/

  def run(records) do
    records
    |> String.split("\n")
    |> Enum.reduce(0, &parse_record/2)
  end

  def power(records) do
    records
    |> String.split("\n")
    |> Enum.reduce(0, &compute_powers/2)
  end

  # "Game 1: 1 green, 2 blue; 13 red, 2 blue, 3 green; 4 green, 14 red"
  def parse_record(record, acc) do
    record
    |> String.split(":")
    |> compute_matches(acc)
  end

  # " 1 green, 2 blue; 13 red, 2 blue, 3 green; 4 green, 14 red"
  def compute_matches([game, game_string], acc) do
    [game_number] = Regex.run(~r/\d+/, game)
    game_number = String.to_integer(game_number)

      game_string
      |> String.split(";")
      |> reduce_rounds()
      |> IO.inspect(limit: :infinity, label: "\n\n\n compute matches")
      |> case do
        nil -> acc
        _ -> acc + game_number
      end
  end

  def compute_matches(_, acc), do: acc

  def reduce_rounds(rounds) do
    rounds
      |> Enum.map(&String.split(&1, ","))
      |> List.flatten()
      |> Enum.reduce_while(:ok, fn game, _acc ->
        captures = Regex.named_captures(@name_captures, game)
        update_counts(captures)
    end)
  end

  defp update_counts(%{"color" => color, "num" => num}) do
    cubes = String.to_integer(num)

    if cubes > Map.get(@game_counts, color) do
      {:halt, nil}
    else
      {:cont, :ok}
    end
  end

  @power_map %{
    "red" => 0,
    "blue" => 0,
    "green" => 0
  }
  def compute_powers(record, acc) do
    game_string =
    case String.split(record, ":") do
      [""] -> ""
      [_, str] -> str
    end


    %{
      "red" => red,
      "blue" => blue,
      "green" => green
    } =
        @name_captures
        |> Regex.scan(game_string)
        |> Enum.reduce(@power_map, fn game, acc ->
          [_, num_string, color] = game
          num = String.to_integer(num_string)

          if num > acc[color] do
            Map.put(acc, color, num)
          else
            acc
          end
        end)

      power = red * green * blue
      acc + power
  end
end
