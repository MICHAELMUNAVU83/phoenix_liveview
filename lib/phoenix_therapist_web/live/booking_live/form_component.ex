defmodule PhoenixTherapistWeb.BookingLive.FormComponent do
  use PhoenixTherapistWeb, :live_component

  alias PhoenixTherapist.Bookings
  alias PhoenixTherapist.AvailableTimes

  @impl true
  def update(%{booking: booking} = assigns, socket) do
    changeset = Bookings.change_booking(booking)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"booking" => booking_params}, socket) do
    changeset =
      socket.assigns.booking
      |> Bookings.change_booking(booking_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"booking" => booking_params}, socket) do
    save_booking(socket, socket.assigns.action, booking_params)
  end

  defp save_booking(socket, :edit, booking_params) do
    case Bookings.update_booking(socket.assigns.booking, booking_params) do
      {:ok, _booking} ->
        {:noreply,
         socket
         |> put_flash(:info, "Booking updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_booking(socket, :new, booking_params) do
    user = socket.assigns.user
    new_booking_params = Map.put(booking_params, "user_id", user.id)

    case Bookings.create_booking(new_booking_params) do
      {:ok, _booking} ->
        {:noreply,
         socket
         |> put_flash(:info, "Booking created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
