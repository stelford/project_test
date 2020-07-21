defmodule TestApp.ImportError do
  use Ecto.Schema

  schema "import_errors" do
    field :loading_file_or_uri, :string
    field :error_generated, :string
    field :input_item, :string

    timestamps()
  end

end
