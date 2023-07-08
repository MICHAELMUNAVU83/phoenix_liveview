defmodule PhoenixTherapist.Repo.Migrations.CreateNotes do
  use Ecto.Migration

  def change do
    create table(:notes) do
      add :description, :string

      timestamps()
    end
  end
end
