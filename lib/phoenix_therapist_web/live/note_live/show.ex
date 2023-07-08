defmodule PhoenixTherapistWeb.NoteLive.Show do
  use PhoenixTherapistWeb, :live_view

  alias PhoenixTherapist.Notes

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:note, Notes.get_note!(id))}
  end

  def handle_event("delete", %{"id" => id}, socket) do
    IO.inspect(id)

    {:noreply
     |> put_flash(:info, "Note deleted successfully.")}
  end

  defp page_title(:show), do: "Show Note"
  defp page_title(:edit), do: "Edit Note"
end
