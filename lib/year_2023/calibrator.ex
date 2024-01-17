defmodule Calibrator do

  @number_map %{
    "zero" => "0",
    "one" => "1",
    "two" => "2",
    "three" => "3",
    "four" => "4",
    "five" => "5",
    "six" => "6",
    "seven" => "7",
    "eight" => "8",
    "nine" => "9"
  }

  @mixed_numbers %{
    "zerone" => "zeroone",
    "twone" => "twoone",
    "oneight" => "oneeight",
    "threeight" => "threeeight",
    "fiveight" => "fiveeight",
    "nineight" => "nineeight",
    "eightwo" => "eighttwo",
    "eighthree" => "eightthree",
    "sevenine" => "sevennine"
  }

  @num_options Map.keys(@number_map) |> Enum.join("|")
  @reg_num Regex.compile!(@num_options)

  def extract_number(string) do
    Regex.replace(~r/\D/, string, "")
  end

  def clean_input(string) do
    Map.keys(@mixed_numbers)
    |> Enum.reduce(string, fn num, acc ->
      num
      |> Regex.compile!
      |> Regex.replace(acc, @mixed_numbers[num])
    end)
  end

  def pre_process_string(string) do
    @reg_num
    |> Regex.scan(string)
    |> List.flatten()
    |> Enum.reduce(string, fn num, acc ->
      num
      |> Regex.compile!()
      |> Regex.replace(acc, @number_map[num])
    end)
  end

  def get_calibration_value(calibration_line) do
    value = extract_number(calibration_line)
    String.first(value) <> String.last(value)
  end

  def calculate_value(input, token \\ "\n") do

    input
    |> split_strings(token)
    |> Enum.reduce(0, &generate_calibration/2)
  end

  defp split_strings(input, token) do
    input
    |> String.split(token)
    |> format_string()
    |> Enum.filter(&(String.length(&1) > 0))
  end

  defp format_string([_|_] = input), do: input
  defp format_string(input), do: [input]

  defp generate_calibration(input, acc) do
    input
    |> clean_input()
    |> pre_process_string()
    |> get_calibration_value()
    |> String.to_integer()
    |> Kernel.+(acc)
  end

end
