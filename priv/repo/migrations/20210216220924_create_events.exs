defmodule Counciltracker.Repo.Migrations.CreateEvents do
  use Ecto.Migration

  def change do
    create_enum_query =
      "CREATE TYPE event_type AS ENUM ('election', 'change_of_affiliation', 'co_option')"
    drop_enum_query =
      "DROP TYPE event_type"

    execute(create_enum_query, drop_enum_query)

    create table(:events, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :processed_at, :utc_datetime
      add :occurred_on, :date, null: false
      add :type, :event_type, null: false
      add :parameters, :map, default: %{}, null: false

      add :authority_id, references(:authorities, on_delete: :delete_all, type: :uuid),
        null: false

      timestamps()
    end

    create(index(:events, [:processed_at]))
    create(index(:events, [:authority_id]))
    create(index(:events, [:occurred_on]))
    create(index(:events, [:type]))

    create_index_query =
      "CREATE INDEX event_parameters ON events USING GIN(parameters)"

    drop_index_query =
      "DROP INDEX event_parameters"

    execute(create_index_query, drop_index_query)
  end
end
