defmodule TestApp.Football.Player.RushingStatistic do
  use Ecto.Schema
  import Ecto.Changeset

  schema "rushing_statistics" do
    field :attempts, :float
    field :attempts_per_game, :float
    field :average_yards, :float
    field :first_downs, :integer
    field :first_downs_pct, :float
    field :fourty_yards_plus, :integer
    field :fumbles, :integer
    field :longest_rush, :string
    field :player_name, :string
    field :player_position, :string
    field :team, :string
    field :total_yards, :float
    field :touchdowns, :integer
    field :twenty_yards_plus, :integer
    field :yards_per_game, :float

    timestamps()
  end

  @doc false
  def changeset(rushing_statistic, attrs) do
    rushing_statistic
    |> cast(attrs, [:player_name, :team, :player_position, :attempts_per_game, :attempts, :total_yards, :average_yards, :yards_per_game, :touchdowns, :longest_rush, :first_downs, :first_downs_pct, :twenty_yards_plus, :fourty_yards_plus, :fumbles])
    |> validate_required([:player_name, :team, :player_position, :attempts_per_game, :attempts, :total_yards, :average_yards, :yards_per_game, :touchdowns, :longest_rush, :first_downs, :first_downs_pct, :twenty_yards_plus, :fourty_yards_plus, :fumbles])
  end

  @doc """
  The initial load function taking in a named file, and for the moment, spitting
  out the first item in the list. Obviously, this is the start of the load into
  Ecto bit..

  I should note that the supplied json file only needs '{"stats": [' added at the
  top instead of '[' and, of course, we need a corresponding '}' at the bottom. 

  Jaxon parses things down to elements and key/value pairs, rather than parsing
  the whole file as one giant json file and then barfing. This means that we can
  then process each json 'record' individually, and be forgiving in what we get in.

  We may not have control over the input data, and if not, this seems the least 
  painful way to deal with it. Remember Postel's law;

  be conservative in what you do, be liberal in what you accept from others

  ```
  iex> TestApp.Football.Player.RushingStatistic.load_json(%{file: "rushing.json"})
  %{
    "1st" => 0,
    "1st%" => 0,
    "20+" => 0,
    "40+" => 0,
    "Att" => 2,
    "Att/G" => 2,
    "Avg" => 3.5,
    "FUM" => 0,
    "Lng" => "7",
    "Player" => "Joe Banyard",
    "Pos" => "RB",
    "TD" => 0,
    "Team" => "JAX",
    "Yds" => 7,
    "Yds/G" => 7
  }
  ```
  """
  def load_json(%{file: file}) do
    file 
    |> File.stream!() 
    |> Jaxon.Stream.from_enumerable() 
    |> Jaxon.Stream.query([:root, "stats", :all]) 
    |> Enum.to_list 
    |> List.first()
  end

end
