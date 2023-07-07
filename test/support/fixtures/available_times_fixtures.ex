defmodule PhoenixTherapist.AvailableTimesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PhoenixTherapist.AvailableTimes` context.
  """

  @doc """
  Generate a available_time.
  """
  def available_time_fixture(attrs \\ %{}) do
    {:ok, available_time} =
      attrs
      |> Enum.into(%{
        date: ~D[2023-07-06],
        time: "some time"
      })
      |> PhoenixTherapist.AvailableTimes.create_available_time()

    available_time
  end
end
