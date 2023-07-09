defmodule PhoenixTherapist.Bookings do
  @moduledoc """
  The Bookings context.
  """

  import Ecto.Query, warn: false
  alias PhoenixTherapist.Repo

  alias PhoenixTherapist.Bookings.Booking

  @doc """
  Returns the list of bookings.

  ## Examples

      iex> list_bookings()
      [%Booking{}, ...]

  """

  def list_bookings_for_a_user(user_id) do
    Repo.all(Booking)
    |> Enum.filter(fn booking -> booking.user_id == user_id end)
    |> Repo.preload(:available_time)
  end

  def list_bookings do
    Repo.all(Booking)
    |> Repo.preload(:available_time)
    |> Repo.preload(:user)
  end

  def list_booked_times_for_a_date(date) do
    Repo.all(Booking)
    |> Repo.preload(:available_time)
    |> Enum.filter(fn booking -> booking.available_time.date == date end)
  end

  def search_bookings_by_user_name(name) do
    query =
      from(b in Booking,
        join: u in assoc(b, :user),
        where: fragment("? LIKE ?", u.first_name, ^"%#{name}%")
      )

    Repo.all(query)
  end

  @doc """
  Gets a single booking.

  Raises `Ecto.NoResultsError` if the Booking does not exist.

  ## Examples

      iex> get_booking!(123)
      %Booking{}

      iex> get_booking!(456)
      ** (Ecto.NoResultsError)

  """
  def get_booking!(id),
    do: Repo.get!(Booking, id) |> Repo.preload(:available_time) |> Repo.preload(:user)

  @doc """
  Creates a booking.

  ## Examples

      iex> create_booking(%{field: value})
      {:ok, %Booking{}}

      iex> create_booking(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_booking(attrs \\ %{}) do
    %Booking{}
    |> Booking.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a booking.

  ## Examples

      iex> update_booking(booking, %{field: new_value})
      {:ok, %Booking{}}

      iex> update_booking(booking, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_booking(%Booking{} = booking, attrs) do
    booking
    |> Booking.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a booking.

  ## Examples

      iex> delete_booking(booking)
      {:ok, %Booking{}}

      iex> delete_booking(booking)
      {:error, %Ecto.Changeset{}}

  """
  def delete_booking(%Booking{} = booking) do
    Repo.delete(booking)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking booking changes.

  ## Examples

      iex> change_booking(booking)
      %Ecto.Changeset{data: %Booking{}}

  """
  def change_booking(%Booking{} = booking, attrs \\ %{}) do
    Booking.changeset(booking, attrs)
  end
end
