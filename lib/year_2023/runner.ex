defmodule Year2023Runner do

  def run() do
    file_path = "/lib/year_2023/data/d_01_01.txt"
    path = File.cwd!() <> file_path

    path
    |> File.read!()
    |> Calibrator.calculate_value()
  end
end
