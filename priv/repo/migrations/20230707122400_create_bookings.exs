defmodule PhoenixTherapist.Repo.Migrations.CreateBookings do
  use Ecto.Migration

  def change do
    create table(:bookings) do
      add :counselor_gender_preference, :string
      add :referred_by, :string
      add :counsulted_before, :string
      add :medical_history, :string
      add :next_of_kin_name, :string
      add :next_of_kin_number, :string
      add :visit, :string

      timestamps()
    end
  end
end
