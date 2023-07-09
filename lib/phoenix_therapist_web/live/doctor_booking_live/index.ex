defmodule PhoenixTherapistWeb.DoctorBookingLive.Index do
  use PhoenixTherapistWeb, :doctor_live_view

  alias PhoenixTherapist.Bookings
  alias PhoenixTherapist.Accounts
  alias PhoenixTherapist.Bookings.Booking

  def mount(_params, session, socket) do
    user = Accounts.get_user_by_session_token(session["user_token"])

    {:ok,
     socket
     |> assign(:live_action, :index)
     |> assign(:bookings, Bookings.list_bookings())
     |> assign(:changeset, Bookings.change_booking(%Booking{}))
     |> assign(:user, user)}
  end

  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Bookings")
    |> assign(:booking, nil)
  end

  def handle_event("search", %{"booking" => booking_params}, socket) do
    IO.inspect(booking_params["search"])

    {:noreply,
     socket
     |> assign(:bookings, Bookings.search_bookings_by_user_name(booking_params["search"]))}
  end
end
