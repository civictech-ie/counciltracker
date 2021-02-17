defmodule Counciltracker.Repo.Migrations.CreateEvents do
  use Ecto.Migration

  def change do
    create_query = "CREATE TYPE event_type AS ENUM ('election', 'change_of_affiliation', 'co_option')"
    drop_query = "DROP TYPE event_type"
    execute(create_query, drop_query)

    create table(:events, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :occurred_on, :date, null: false
      add :type, :event_type, null: false
      add :authority_id, references(:authorities, on_delete: :delete_all, type: :uuid), null: false

      timestamps()
    end

    create(index(:events, [:authority_id]))
    create(index(:events, [:occurred_on]))
    create(index(:events, [:type]))
  end
end
