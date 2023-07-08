defmodule PhoenixTherapist.Bookings.Booking do
  use Ecto.Schema
  import Ecto.Changeset

  schema "bookings" do
    field(:counselor_gender_preference, :string)
    field(:counsulted_before, :string)
    field(:medical_history, :string)
    field(:next_of_kin_name, :string)
    field(:next_of_kin_number, :string)
    field(:referred_by, :string)
    field(:visit, :string)
    belongs_to(:available_time, PhoenixTherapist.AvailableTimes.AvailableTime)
    belongs_to(:user, PhoenixTherapist.Accounts.User)
    has_many(:notes, PhoenixTherapist.Notes.Note)

    timestamps()
  end

  @doc false
  def changeset(booking, attrs) do
    booking
    |> cast(attrs, [
      :counselor_gender_preference,
      :referred_by,
      :counsulted_before,
      :medical_history,
      :next_of_kin_name,
      :next_of_kin_number,
      :visit,
      :available_time_id,
      :user_id
    ])
    |> validate_required([
      :counselor_gender_preference,
      :referred_by,
      :counsulted_before,
      :medical_history,
      :next_of_kin_name,
      :next_of_kin_number,
      :visit,
      :available_time_id,
      :user_id
    ])
  end
end
