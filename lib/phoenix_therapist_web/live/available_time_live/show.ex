defmodule PhoenixTherapistWeb.AvailableTimeLive.Show do
  use PhoenixTherapistWeb, :live_view

  alias PhoenixTherapist.AvailableTimes

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:available_time, AvailableTimes.get_available_time!(id))}
  end

  defp page_title(:show), do: "Show Available time"
  defp page_title(:edit), do: "Edit Available time"
end
