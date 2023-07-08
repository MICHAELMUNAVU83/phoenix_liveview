defmodule PhoenixTherapist.Notes.Note do
  use Ecto.Schema
  import Ecto.Changeset

  schema "notes" do
    field :description, :string
    belongs_to :booking, PhoenixTherapist.Bookings.Booking

    timestamps()
  end

  @doc false
  def changeset(note, attrs) do
    note
    |> cast(attrs, [:description, :booking_id])
    |> validate_required([:description, :booking_id])
  end
end
