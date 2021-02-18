defmodule Counciltracker.Repo.Migrations.CreateTerms do
  use Ecto.Migration

  def change do
    create table(:terms, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :starts_on, :date, null: false
      add :ends_on, :date
      add :authority_id, references(:authorities, on_delete: :nothing, type: :uuid), null: false
      add :councillor_id, references(:councillors, on_delete: :nothing, type: :uuid), null: false

      timestamps()
    end

    alter table(:councillors) do
      remove :authority_id, :uuid
    end

    create index(:terms, [:starts_on])
    create index(:terms, [:ends_on])
    create index(:terms, [:authority_id])
    create index(:terms, [:councillor_id])
    create index(:terms, [:authority_id, :councillor_id])
  end
end
