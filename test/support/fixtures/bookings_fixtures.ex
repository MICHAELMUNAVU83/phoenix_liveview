defmodule PhoenixTherapist.BookingsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PhoenixTherapist.Bookings` context.
  """

  @doc """
  Generate a booking.
  """
  def booking_fixture(attrs \\ %{}) do
    {:ok, booking} =
      attrs
      |> Enum.into(%{
        counselor_gender_preference: "some counselor_gender_preference",
        counsulted_before: "some counsulted_before",
        medical_history: "some medical_history",
        next_of_kin_name: "some next_of_kin_name",
        next_of_kin_number: "some next_of_kin_number",
        referred_by: "some referred_by",
        visit: "some visit"
      })
      |> PhoenixTherapist.Bookings.create_booking()

    booking
  end
end
