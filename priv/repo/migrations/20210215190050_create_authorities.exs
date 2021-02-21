defmodule Counciltracker.Repo.Migrations.CreateAuthorities do
  use Ecto.Migration

  def change do
    create table(:authorities, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :text, null: false
      add :hosts, {:array, :text}, default: [], null: false

      timestamps()
    end

    create(index(:authorities, [:hosts]))
  end
end
