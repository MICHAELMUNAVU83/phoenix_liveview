defmodule PhoenixTherapist.Repo.Migrations.CreateBookings do
  use Ecto.Migration

  def change do
    create table(:bookings) do
      add(:counselor_gender_preference, :string)
      add(:referred_by, :string)
      add(:counsulted_before, :string)
      add(:medical_history, :string)
      add(:next_of_kin_name, :string)
      add(:next_of_kin_number, :string)
      add(:visit, :string)
      add(:available_time_id, references(:available_times, on_delete: :delete_all), null: false)
      add(:user_id, references(:users, on_delete: :delete_all), null: false)

      timestamps()
    end
  end
end
