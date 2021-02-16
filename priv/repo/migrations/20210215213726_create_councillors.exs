defmodule Counciltracker.Repo.Migrations.CreateCouncillors do
  use Ecto.Migration

  def change do
    create table(:councillors, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :surname, :text, default: ""
      add :given_name, :text, default: ""
      add :slug, :text, null: false
      add :council_id, references(:councils, on_delete: :delete_all, type: :uuid), null: false

      timestamps()
    end

    create index(:councillors, [:council_id])
    create index(:councillors, [:council_id, :slug])
  end
end