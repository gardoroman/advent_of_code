defmodule Year2023Runner do
alias Year2023.CubeGame

  def calibrate() do
    file_path = "/lib/year_2023/data/calibration_values.txt"
    path = File.cwd!() <> file_path

    path
    |> File.read!()
    |> Calibrator.calculate_value()
  end

  def cube_game() do
    file_path = "/lib/year_2023/data/cube_games.txt"
    path = File.cwd!() <> file_path

    path
    |> File.read!()
    |> CubeGame.run()
  end
  def power() do
    file_path = "/lib/year_2023/data/cube_games.txt"
    path = File.cwd!() <> file_path

    path
    |> File.read!()
    |> CubeGame.power()
  end
end
