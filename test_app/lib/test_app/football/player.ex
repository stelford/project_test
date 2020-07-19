defmodule TestApp.Football.Player do
  @moduledoc """
  The Football.Player context.
  """

  import Ecto.Query, warn: false
  alias TestApp.Repo

  alias TestApp.Football.Player.RushingStatistic

  @doc """
  Returns the list of rushing_statistics.

  ## Examples

      iex> list_rushing_statistics()
      [%RushingStatistic{}, ...]

  """
  def list_rushing_statistics do
    Repo.all(RushingStatistic)
  end

  @doc """
  Gets a single rushing_statistic.

  Raises `Ecto.NoResultsError` if the Rushing statistic does not exist.

  ## Examples

      iex> get_rushing_statistic!(123)
      %RushingStatistic{}

      iex> get_rushing_statistic!(456)
      ** (Ecto.NoResultsError)

  """
  def get_rushing_statistic!(id), do: Repo.get!(RushingStatistic, id)

  @doc """
  Creates a rushing_statistic.

  ## Examples

      iex> create_rushing_statistic(%{field: value})
      {:ok, %RushingStatistic{}}

      iex> create_rushing_statistic(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_rushing_statistic(attrs \\ %{}) do
    %RushingStatistic{}
    |> RushingStatistic.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a rushing_statistic.

  ## Examples

      iex> update_rushing_statistic(rushing_statistic, %{field: new_value})
      {:ok, %RushingStatistic{}}

      iex> update_rushing_statistic(rushing_statistic, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_rushing_statistic(%RushingStatistic{} = rushing_statistic, attrs) do
    rushing_statistic
    |> RushingStatistic.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a rushing_statistic.

  ## Examples

      iex> delete_rushing_statistic(rushing_statistic)
      {:ok, %RushingStatistic{}}

      iex> delete_rushing_statistic(rushing_statistic)
      {:error, %Ecto.Changeset{}}

  """
  def delete_rushing_statistic(%RushingStatistic{} = rushing_statistic) do
    Repo.delete(rushing_statistic)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking rushing_statistic changes.

  ## Examples

      iex> change_rushing_statistic(rushing_statistic)
      %Ecto.Changeset{data: %RushingStatistic{}}

  """
  def change_rushing_statistic(%RushingStatistic{} = rushing_statistic, attrs \\ %{}) do
    RushingStatistic.changeset(rushing_statistic, attrs)
  end
end
