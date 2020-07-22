defmodule TestAppWeb.ReportController do
  use TestAppWeb, :controller

  import Ecto.Query
  alias TestApp.Football.Player.RushingStatistic, as: RushingStatistic

  def rushing_statistic_to_csv(conn, params) do
    filename="RushingStats_" <> current_datetime_as_string() <> ".csv"

    with {:ok, file} <- generate_file_for_csv_report(filename, params)
    do
      conn
      |> put_resp_content_type("text/csv")
      |> put_resp_header("content-disposition", "attachment; filename=\"" <> filename <> "\"")
      |> send_download({:file, filename})
    end
  end

  def generate_file_for_csv_report(filename, params) do
    {:ok, file} = File.open(filename, [:write, :utf8])

    query_for_csv_report(params)
    |> remove_schema_and_meta()
    |> CSV.encode(headers: RushingStatistic.__schema__(:fields))
    |> Enum.each(&IO.write(file, &1))

    {:ok, file}
  end

  defp query_for_csv_report(%{"filter_player_name" => filter_player_name, "order_by" => order_by, "asc_or_desc" => "asc"}) do
    from(a in RushingStatistic,
      where: ilike(a.player_name, ^(filter_player_name <> "%")),
      order_by: [asc: ^String.to_atom(order_by)]
    )
    |> TestApp.Repo.all()
  end

  defp query_for_csv_report(%{"filter_player_name" => filter_player_name, "order_by" => order_by, "asc_or_desc" => "desc"}) do
    from(a in RushingStatistic,
      where: ilike(a.player_name, ^(filter_player_name <> "%")),
      order_by: [desc: ^String.to_atom(order_by)]
    )
    |> TestApp.Repo.all()
  end

  defp remove_schema_and_meta(results_from_query) do
    Enum.map(results_from_query, fn x -> x |> Map.delete(:__meta__) |> Map.delete(:__struct__); end)
  end

  defp current_datetime_as_string() do
    # call out to erlang.. because, honestly, the calendar there is pretty bulletproof and fast
    # but also because, as you will see down below, their padding/format is slightly nicer. It
    # doesn't require us to convert the integer to string and then back again for example
    {{year, month, day}, {hour, minute, second}} = :calendar.local_time()
    "#{year}#{erlang_pad(day)}#{erlang_pad(month)}_#{erlang_pad(hour)}#{erlang_pad(minute)}#{erlang_pad(second)}"
  end

  def erlang_pad(number) do
    # and let me count how many times :io.format vs :io_lib.format has bitten me on the tucas.. sigh
    :io_lib.format("~2..0B", [number]) 
  end
end
