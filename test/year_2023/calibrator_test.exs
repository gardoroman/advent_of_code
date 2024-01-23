defmodule Year2023.CalibratorTest do
  use ExUnit.Case, async: true

  describe "calibration values" do

    test "extracts numeric values from string" do
      string_1 = "string_1"
      assert Calibrator.extract_number(string_1) == "1"
    end

    test "extract values from string with 2 digits" do
      calibration_line = "str1ng0"
      assert Calibrator.get_calibration_value(calibration_line) == "10"
    end

    test "extract values from string with 1 digit" do
      calibration_line = "str1ng"
      assert Calibrator.get_calibration_value(calibration_line) == "11"
    end

    test "extract values from string with more than 2 digits" do
      calibration_line = "str1234ng5"
      assert Calibrator.get_calibration_value(calibration_line) == "15"
    end

    test "get coordinates from calibration values" do

      string =
        """
        1abc2
        pqr3stu8vwx
        a1b2c3d4e5f
        treb7uchet
        """

        assert Calibrator.calculate_value(string) == 142
    end

    test "converts spelled numbers to actual numbers" do
      string_1 = "2string6seven"
      assert Calibrator.pre_process_string(string_1) == "2string67"
    end

    test "converts combined spelled numbers to actual numbers" do
      string_1 = "2string6sevenine"
      assert Calibrator.clean_input(string_1) == "2string6sevennine"
    end

    test "generates value for number and number strings" do
      string =
        """
        two1nine
        eightwothree
        abcone2threexyz
        xtwone3four
        4nineeightseven2
        zoneight234
        7pqrstsixteen
        """

        assert Calibrator.calculate_value(string) == 281
    end

  end
end
