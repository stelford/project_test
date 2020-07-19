defmodule TestApp.Repo.Migrations.CreateRushingStatistics do
  use Ecto.Migration

  def change do
    create table(:rushing_statistics) do
      add :player_name, :string
      add :team, :string
      add :player_position, :string
      add :attempts_per_game, :float
      add :attempts, :float
      add :total_yards, :float
      add :average_yards, :float
      add :yards_per_game, :float
      add :touchdowns, :integer
      add :longest_rush, :string
      add :first_downs, :integer
      add :first_downs_pct, :float
      add :twenty_yards_plus, :integer
      add :fourty_yards_plus, :integer
      add :fumbles, :integer

      timestamps()
    end

  end
end
