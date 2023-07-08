defmodule PhoenixTherapistWeb.BookingLive.Show do
  use PhoenixTherapistWeb, :live_view

  alias PhoenixTherapist.Bookings
  alias PhoenixTherapist.Bookings.Booking
  alias PhoenixTherapist.Notes
  alias PhoenixTherapist.Notes.Note

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> assign(:notes, Notes.list_notes())}
  end

  @impl true
  def handle_params(params, _uri, socket) do
    IO.inspect(socket.assigns.live_action)

    IO.inspect(params)

    note =
      if params["note_id"] do
        Notes.get_note!(params["note_id"])
      else
        %Note{}
      end

    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:booking, Bookings.get_booking!(params["id"]))
     |> assign(:note, note)}
  end

  def handle_event("delete", %{"id" => id}, socket) do
    note = Notes.get_note!(id)
    {:ok, _} = Notes.delete_note(note)

    {:noreply,
     socket
     |> assign(:notes, Notes.list_notes())
     |> put_flash(:info, "Note deleted successfully")}
  end

  defp page_title(:show), do: "Show Booking"
  defp page_title(:edit), do: "Edit Booking"
  defp page_title(:addnotes), do: "Add Note"
  defp page_title(:editnote), do: "Edit Note"
end
