defmodule TestAppWeb.RushingStatisticController do
  use TestAppWeb, :controller

  alias TestApp.Football.Player
  alias TestApp.Football.Player.RushingStatistic

  def index(conn, _params) do
    rushing_statistics = Player.list_rushing_statistics()
    render(conn, "index.html", rushing_statistics: rushing_statistics)
  end

  def new(conn, _params) do
    changeset = Player.change_rushing_statistic(%RushingStatistic{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"rushing_statistic" => rushing_statistic_params}) do
    case Player.create_rushing_statistic(rushing_statistic_params) do
      {:ok, rushing_statistic} ->
        conn
        |> put_flash(:info, "Rushing statistic created successfully.")
        |> redirect(to: Routes.rushing_statistic_path(conn, :show, rushing_statistic))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    rushing_statistic = Player.get_rushing_statistic!(id)
    render(conn, "show.html", rushing_statistic: rushing_statistic)
  end

  def edit(conn, %{"id" => id}) do
    rushing_statistic = Player.get_rushing_statistic!(id)
    changeset = Player.change_rushing_statistic(rushing_statistic)
    render(conn, "edit.html", rushing_statistic: rushing_statistic, changeset: changeset)
  end

  def update(conn, %{"id" => id, "rushing_statistic" => rushing_statistic_params}) do
    rushing_statistic = Player.get_rushing_statistic!(id)

    case Player.update_rushing_statistic(rushing_statistic, rushing_statistic_params) do
      {:ok, rushing_statistic} ->
        conn
        |> put_flash(:info, "Rushing statistic updated successfully.")
        |> redirect(to: Routes.rushing_statistic_path(conn, :show, rushing_statistic))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", rushing_statistic: rushing_statistic, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    rushing_statistic = Player.get_rushing_statistic!(id)
    {:ok, _rushing_statistic} = Player.delete_rushing_statistic(rushing_statistic)

    conn
    |> put_flash(:info, "Rushing statistic deleted successfully.")
    |> redirect(to: Routes.rushing_statistic_path(conn, :index))
  end
end
