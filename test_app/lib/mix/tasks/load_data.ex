defmodule Mix.Tasks.LoadData do
  use Mix.Task
  alias TestApp.Repo

  @shortdoc "Call over to the TestApp data loader for RushingStatistics."
  def run(_) do
    [:postgrex, :ecto] |> Enum.each(&Application.ensure_all_started/1)

    Repo.start_link

    TestApp.Football.Player.RushingStatistic.load_json(%{file: "fixtures/rushing.json"})
  end
end
