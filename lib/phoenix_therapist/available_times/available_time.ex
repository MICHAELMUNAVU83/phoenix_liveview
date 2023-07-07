defmodule PhoenixTherapist.AvailableTimes.AvailableTime do
  use Ecto.Schema
  import Ecto.Changeset

  schema "available_times" do
    field(:date, :string)
    field(:time, :time)
    has_many(:bookings, PhoenixTherapist.Bookings.Booking)

    timestamps()
  end

  @doc false
  def changeset(available_time, attrs) do
    available_time
    |> cast(attrs, [:time, :date])
    |> validate_required([:time, :date])
  end
end
