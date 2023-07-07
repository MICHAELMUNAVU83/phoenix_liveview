defmodule PhoenixTherapist.AvailableTimes do
  @moduledoc """
  The AvailableTimes context.
  """

  import Ecto.Query, warn: false
  alias PhoenixTherapist.Repo

  alias PhoenixTherapist.AvailableTimes.AvailableTime

  @doc """
  Returns the list of available_times.

  ## Examples

      iex> list_available_times()
      [%AvailableTime{}, ...]

  """
  def list_available_times do
    Repo.all(AvailableTime)
  end

  def list_available_times_for_a_date(date) do
    Repo.all(AvailableTime)
    |> Repo.preload(:bookings)
    |> Enum.filter(fn available_time -> available_time.date == date end)
    |> Enum.filter(fn available_time -> available_time.bookings == [] end)
    |> Enum.map(fn available_time -> {available_time.time, available_time.id} end)
  end

  def list_times_selected_for_a_date(date) do
    Repo.all(AvailableTime)
    |> Repo.preload(:bookings)
    |> Enum.filter(fn available_time -> available_time.date == date end)
  end

  def times_for_a_date(date) do
    query =
      from(a in AvailableTime,
        where: a.date == ^date
      )

    Repo.all(query)
  end

  def list_available_dates() do
    query =
      from(a in AvailableTime,
        select: a.date
      )

    Repo.all(query)
  end

  @doc """
  Gets a single available_time.

  Raises `Ecto.NoResultsError` if the Available time does not exist.

  ## Examples

      iex> get_available_time!(123)
      %AvailableTime{}

      iex> get_available_time!(456)
      ** (Ecto.NoResultsError)

  """
  def get_available_time!(id), do: Repo.get!(AvailableTime, id)

  @doc """
  Creates a available_time.

  ## Examples

      iex> create_available_time(%{field: value})
      {:ok, %AvailableTime{}}

      iex> create_available_time(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_available_time(attrs \\ %{}) do
    %AvailableTime{}
    |> AvailableTime.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a available_time.

  ## Examples

      iex> update_available_time(available_time, %{field: new_value})
      {:ok, %AvailableTime{}}

      iex> update_available_time(available_time, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_available_time(%AvailableTime{} = available_time, attrs) do
    available_time
    |> AvailableTime.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a available_time.

  ## Examples

      iex> delete_available_time(available_time)
      {:ok, %AvailableTime{}}

      iex> delete_available_time(available_time)
      {:error, %Ecto.Changeset{}}

  """
  def delete_available_time(%AvailableTime{} = available_time) do
    Repo.delete(available_time)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking available_time changes.

  ## Examples

      iex> change_available_time(available_time)
      %Ecto.Changeset{data: %AvailableTime{}}

  """
  def change_available_time(%AvailableTime{} = available_time, attrs \\ %{}) do
    AvailableTime.changeset(available_time, attrs)
  end
end
