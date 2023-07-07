defmodule PhoenixTherapistWeb.AvailableTimeLive.FormComponent do
  use PhoenixTherapistWeb, :live_component

  alias PhoenixTherapist.AvailableTimes

  @impl true
  def update(%{available_time: available_time} = assigns, socket) do
    changeset = AvailableTimes.change_available_time(available_time)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"available_time" => available_time_params}, socket) do
    changeset =
      socket.assigns.available_time
      |> AvailableTimes.change_available_time(available_time_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"available_time" => available_time_params}, socket) do
    save_available_time(socket, socket.assigns.action, available_time_params)
  end

  defp save_available_time(socket, :edit, available_time_params) do
    case AvailableTimes.update_available_time(
           socket.assigns.available_time,
           available_time_params
         ) do
      {:ok, _available_time} ->
        {:noreply,
         socket
         |> put_flash(:info, "Available time updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_available_time(socket, :new, available_time_params) do
    times_selected = AvailableTimes.times_for_a_date(available_time_params["date"])

    if length(times_selected) >= 4 do
      {:noreply,
       socket
       |> put_flash(:error, "You can only have 4 available times per day")
       |> push_redirect(to: socket.assigns.return_to)}
    else
      case AvailableTimes.create_available_time(available_time_params) do
        {:ok, _available_time} ->
          {:noreply,
           socket
           |> put_flash(:info, "Available time created successfully")
           |> push_redirect(to: socket.assigns.return_to)}

        {:error, %Ecto.Changeset{} = changeset} ->
          {:noreply, assign(socket, changeset: changeset)}
      end
    end
  end
end
