defmodule TestApp.Repo.Migrations.EnsureLongestRushIsInteger do
  use Ecto.Migration

  def up do
    execute """
      ALTER TABLE rushing_statistics ALTER COLUMN longest_rush TYPE integer USING CAST(longest_rush AS integer)
    """
  end

  def raise do
    raise Ecto.MigrationError, message: "Migration was one way from varchar to integer. Cowardly Refusing to reverse"
  end
end
