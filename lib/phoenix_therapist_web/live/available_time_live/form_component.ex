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
    times_selected_for_a_date = AvailableTimes.times_for_a_date(available_time_params["date"])

    time_already_selected =
      Enum.any?(times_selected_for_a_date, fn time ->
        time.time == available_time_params["time"]
      end)

    if !time_already_selected do
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
    else
      {:noreply,
       socket
       |> put_flash(:error, "You already have an opening set at this time and date")
       |> push_redirect(to: socket.assigns.return_to)}
    end
  end

  defp save_available_time(socket, :new, available_time_params) do
    times_selected = AvailableTimes.times_for_a_date(available_time_params["date"])
    times_selected_for_a_date = AvailableTimes.times_for_a_date(available_time_params["date"])

    time_already_selected =
      Enum.any?(times_selected_for_a_date, fn time ->
        time.time == available_time_params["time"]
      end)

    if !time_already_selected do
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
    else
      {:noreply,
       socket
       |> put_flash(:error, "You already have an opening set at this time and date")
       |> push_redirect(to: socket.assigns.return_to)}
    end
  end
end
