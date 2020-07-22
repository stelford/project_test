defmodule TestApp.Football.Player.RushingStatisticTest do
  use TestApp.DataCase
  import Ecto.Query

  alias TestApp.Football.Player.RushingStatistic
  alias TestApp.ImportError

  describe "loading json in happy path" do
    test "loading a valid json file works" do
      rs = RushingStatistic
      rs.load_json(%{file: "fixtures/normal.json"})

      count = from(a in RushingStatistic, select: count(a.id)) |> TestApp.Repo.one()
      assert count == 1
    end

    test "loading a damaged json with longest_rushing and total_yards still works" do
      rs = RushingStatistic
      rs.load_json(%{file: "fixtures/bad_data.json"})

      first_rs = from(a in RushingStatistic) |> TestApp.Repo.one()
      assert first_rs.total_yards == 1234
      assert first_rs.longest_rush == 85 
    end
  end

  describe "loading very bad json results in unhappy path" do
    test "loading an invalid json means an entry into import errors table" do
      rs = RushingStatistic
      rs.load_json(%{file: "fixtures/very_bad_data.json"})

      rs_count = from(a in RushingStatistic, select: count(a.id)) |> TestApp.Repo.one()
      assert rs_count == 0
      error_count = from(a in ImportError, select: count(a.id)) |> TestApp.Repo.one()
      assert error_count == 1

      first_error = from(a in ImportError) |> TestApp.Repo.one()
      assert first_error.error_generated =~ "fumbles: is invalid"
    end
  end

end
