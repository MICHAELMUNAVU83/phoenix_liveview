defmodule PhoenixTherapistWeb.DoctorBookingLive.Index do
  use PhoenixTherapistWeb, :doctor_live_view

  alias PhoenixTherapist.Bookings
  alias PhoenixTherapist.Accounts

  def mount(_params, session, socket) do
    user = Accounts.get_user_by_session_token(session["user_token"])

    IO.inspect(user)

    {:ok,
     socket
     |> assign(:live_action, :index)
     |> assign(:bookings, Bookings.list_bookings())
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
end
