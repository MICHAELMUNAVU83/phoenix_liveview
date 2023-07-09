defmodule PhoenixTherapistWeb.AvailableTimeLive.Index do
  use PhoenixTherapistWeb, :doctor_live_view

  alias PhoenixTherapist.AvailableTimes
  alias PhoenixTherapist.AvailableTimes.AvailableTime

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :available_times, list_available_times())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Available time")
    |> assign(:available_time, AvailableTimes.get_available_time!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Available time")
    |> assign(:available_time, %AvailableTime{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Available times")
    |> assign(:available_time, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    available_time = AvailableTimes.get_available_time!(id)
    IO.inspect(available_time)

    IO.inspect(length(available_time.bookings))

    if length(available_time.bookings) == 0 do
      {:ok, _} = AvailableTimes.delete_available_time(available_time)

      {:noreply, assign(socket, :available_times, list_available_times())}
    else
      {:noreply,
       socket
       |> assign(:page_title, "Listing Available times")
       |> put_flash(:error, "Cannot delete available as it has bookings")}
    end
  end

  defp list_available_times do
    AvailableTimes.list_available_times()
  end
end
