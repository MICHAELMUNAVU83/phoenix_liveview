defmodule PhoenixTherapistWeb.BookingLive.Index do
  use PhoenixTherapistWeb, :live_view

  alias PhoenixTherapist.Bookings
  alias PhoenixTherapist.Bookings.Booking
  alias PhoenixTherapist.AvailableTimes

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :bookings, list_bookings())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Booking")
    |> assign(:booking, Bookings.get_booking!(id))
  end

  defp apply_action(socket, :new, _params) do
    available_times =
      AvailableTimes.list_available_times()
      |> Enum.map(fn available_time -> {available_time.time, available_time.id} end)

    socket
    |> assign(:page_title, "New Booking")
    |> assign(:available_times, available_times)
    |> assign(:booking, %Booking{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Bookings")
    |> assign(:booking, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    booking = Bookings.get_booking!(id)
    {:ok, _} = Bookings.delete_booking(booking)

    {:noreply, assign(socket, :bookings, list_bookings())}
  end

  defp list_bookings do
    Bookings.list_bookings()
  end
end
