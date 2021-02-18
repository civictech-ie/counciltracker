defmodule Counciltracker.Repo.Migrations.CreateCouncillors do
  use Ecto.Migration

  def change do
    create table(:councillors, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :surname, :text, null: false, default: ""
      add :given_name, :text, null: false, default: ""
      add :slug, :text, null: false

      add :authority_id, references(:authorities, on_delete: :delete_all, type: :uuid),
        null: false

      timestamps()
    end

    create index(:councillors, [:authority_id])
    create index(:councillors, [:authority_id, :slug])
  end
end
