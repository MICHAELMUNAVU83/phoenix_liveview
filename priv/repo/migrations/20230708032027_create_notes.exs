defmodule PhoenixTherapist.Repo.Migrations.CreateNotes do
  use Ecto.Migration

  def change do
    create table(:notes) do
      add :description, :string
      add :booking_id, references(:bookings, on_delete: :nothing)

      timestamps()
    end
  end
end
