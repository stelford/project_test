defmodule TestApp.Repo.Migrations.CreateImportErrors do
  use Ecto.Migration

  def change do
    create table("import_errors") do
      # totally understand that in db design unbounded strings are bad ("bad")
      add :loading_file_or_uri, :string
      add :error_generated, :string
      add :input_item, :string
      timestamps()
    end
  end
end
