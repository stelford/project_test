defmodule TestApp.Football.Player.RushingStatistic do
  use Ecto.Schema
  import Ecto.Changeset
  alias TestApp.ImportError

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

  This code is also not idempotent. Re-running it WILL cause duplicates to be loaded.
  That's obviously not awesome, but, without something like dob along with the players name
  it is always possible that any composite key we make off of name-team will not be unique

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
    |> Enum.each(fn x -> insert_into_ecto(file, x) end)
  end

  @doc """
    When doing an insert, sometimes we get bad data. Life happens. We can try to
    demunge the data, but it's probably "saner" to jst log invalid input/json elements
    into an import_error table. There is an almost infinite ways that someone can
    mess up a json data, but, usually, it's not the entire file that is messed. 
  """
  def insert_into_ecto(file_or_uri, enum_item) do
    with {:ok, map_converted} <- map_to_ecto_keys(enum_item),
         {:ok, record} <- TestApp.Football.Player.create_rushing_statistic(map_converted)
    do
      {:ok, record}
    else
      {:error, reason} -> log_error_during_load(file_or_uri, reason, enum_item)
    end
  end

  def log_error_during_load(file_or_uri, reason, input) do
    error_string = changeset_error_to_string(reason)
    %ImportError{:loading_file_or_uri => file_or_uri,
                 :error_generated => error_string,
                 :input_item => Jason.encode!(input)}
    |> TestApp.Repo.insert()
  end

  def map_to_ecto_keys(incoming_map) do
    conversion_map = %{"1st" => :first_downs,
      "1st%" => :first_downs_pct,
      "20+" => :twenty_yards_plus,
      "40+" => :fourty_yards_plus,
      "Att" => :attempts,
      "Att/G" => :attempts_per_game,
      "Avg" => :average_yards,
      "FUM" => :fumbles,
      "Lng" => :longest_rush,
      "Player" => :player_name,
      "Pos" => :player_position,
      "TD" => :touchdowns,
      "Team" => :team,
      "Yds" => :total_yards,
      "Yds/G" => :yards_per_game
    }
    resulting_map = Map.new(incoming_map, fn {k,v} -> {Map.get(conversion_map, k), v} end)
    {:ok, resulting_map}
  end

  # shamelessly grabbed from https://elixirforum.com/t/collecting-and-formatting-changeset-errors/20191
  # Why there is no error to string function already on the changeset, I have no idea
  # Also, fwiw, I am not a huge fan of the code below, it looks... noisy. Ah well. It works
  # which is good enough to unblock me for the moment - Stef (Mon/20/2020 20:14)
  def changeset_error_to_string(changeset) do
    Ecto.Changeset.traverse_errors(changeset, fn {msg, opts} ->
      Enum.reduce(opts, msg, fn {key, value}, acc ->
        String.replace(acc, "%{#{key}}", to_string(value))
      end)
    end)
    |> Enum.reduce("", fn {k, v}, acc ->
      joined_errors = Enum.join(v, "; ")
      "#{acc}#{k}: #{joined_errors}\n"
    end)
  end

end
