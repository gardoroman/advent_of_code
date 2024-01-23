defmodule Year2023.CubeGameTest do
  use ExUnit.Case, async: true

  describe "cube game" do
    test "parse game record" do
      input = "Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green"
      ["Game 1", ["3 blue", " 4 red; 1 red", " 2 green", " 6 blue; 2 green"]]
    end



    test "only count games that match" do

    end
  end
end
