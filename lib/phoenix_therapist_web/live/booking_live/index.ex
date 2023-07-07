defmodule PhoenixTherapistWeb.BookingLive.Index do
  use PhoenixTherapistWeb, :live_view

  alias PhoenixTherapist.Bookings
  alias PhoenixTherapist.Bookings.Booking
  alias PhoenixTherapist.AvailableTimes

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:live_action, :index)
     |> assign(:bookings, Bookings.list_bookings())
     |> assign(:selected_date, "")
     |> assign(
       :date_changeset,
       AvailableTimes.change_available_time(%AvailableTimes.AvailableTime{})
     )}
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
    available_times = AvailableTimes.list_available_times_for_a_date(socket.assigns.selected_date)

    IO.inspect(available_times)

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

  def handle_event("search_available_times", %{"available_time" => %{"date" => date}}, socket) do
    IO.inspect(date)

    number_of_times_date_is_booked = length(Bookings.list_booked_times_for_a_date(date))
    IO.inspect(number_of_times_date_is_booked)

    slots_available =
      if number_of_times_date_is_booked < 4 do
        4 - number_of_times_date_is_booked
      else
        0
      end

    doctor_available_for_date = Enum.member?(AvailableTimes.list_available_dates(), date)

    IO.inspect(doctor_available_for_date)

    if doctor_available_for_date do
      if number_of_times_date_is_booked == 4 do
        {:noreply,
         socket
         |> assign(:selected_date, "")
         |> assign(
           :date_changeset,
           AvailableTimes.change_available_time(%AvailableTimes.AvailableTime{date: date})
         )
         |> put_flash(:error, "This date is fully booked")}
      else
        {:noreply,
         socket
         |> assign(:selected_date, date)
         |> assign(
           :date_changeset,
           AvailableTimes.change_available_time(%AvailableTimes.AvailableTime{date: date})
         )
         |> put_flash(:info, "There are #{slots_available} slots available for #{date}")}
      end
    else
      {:noreply,
       socket
       |> assign(:selected_date, "")
       |> assign(
         :date_changeset,
         AvailableTimes.change_available_time(%AvailableTimes.AvailableTime{date: date})
       )
       |> put_flash(:error, "The doctor is not available for #{date}")}
    end
  end

  defp list_bookings do
    Bookings.list_bookings()
  end
end
