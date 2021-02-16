defmodule Counciltracker.Repo.Migrations.CreateCouncils do
  use Ecto.Migration

  def change do
    create table(:councils, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :text, null: false

      timestamps()
    end
  end
end
