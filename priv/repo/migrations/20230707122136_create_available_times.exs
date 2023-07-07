defmodule PhoenixTherapist.Repo.Migrations.CreateAvailableTimes do
  use Ecto.Migration

  def change do
    create table(:available_times) do
      add :time, :time
      add :date, :date

      timestamps()
    end
  end
end
