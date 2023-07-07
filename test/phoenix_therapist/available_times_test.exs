defmodule PhoenixTherapist.AvailableTimesTest do
  use PhoenixTherapist.DataCase

  alias PhoenixTherapist.AvailableTimes

  describe "available_times" do
    alias PhoenixTherapist.AvailableTimes.AvailableTime

    import PhoenixTherapist.AvailableTimesFixtures

    @invalid_attrs %{date: nil, time: nil}

    test "list_available_times/0 returns all available_times" do
      available_time = available_time_fixture()
      assert AvailableTimes.list_available_times() == [available_time]
    end

    test "get_available_time!/1 returns the available_time with given id" do
      available_time = available_time_fixture()
      assert AvailableTimes.get_available_time!(available_time.id) == available_time
    end

    test "create_available_time/1 with valid data creates a available_time" do
      valid_attrs = %{date: ~D[2023-07-06], time: "some time"}

      assert {:ok, %AvailableTime{} = available_time} = AvailableTimes.create_available_time(valid_attrs)
      assert available_time.date == ~D[2023-07-06]
      assert available_time.time == "some time"
    end

    test "create_available_time/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = AvailableTimes.create_available_time(@invalid_attrs)
    end

    test "update_available_time/2 with valid data updates the available_time" do
      available_time = available_time_fixture()
      update_attrs = %{date: ~D[2023-07-07], time: "some updated time"}

      assert {:ok, %AvailableTime{} = available_time} = AvailableTimes.update_available_time(available_time, update_attrs)
      assert available_time.date == ~D[2023-07-07]
      assert available_time.time == "some updated time"
    end

    test "update_available_time/2 with invalid data returns error changeset" do
      available_time = available_time_fixture()
      assert {:error, %Ecto.Changeset{}} = AvailableTimes.update_available_time(available_time, @invalid_attrs)
      assert available_time == AvailableTimes.get_available_time!(available_time.id)
    end

    test "delete_available_time/1 deletes the available_time" do
      available_time = available_time_fixture()
      assert {:ok, %AvailableTime{}} = AvailableTimes.delete_available_time(available_time)
      assert_raise Ecto.NoResultsError, fn -> AvailableTimes.get_available_time!(available_time.id) end
    end

    test "change_available_time/1 returns a available_time changeset" do
      available_time = available_time_fixture()
      assert %Ecto.Changeset{} = AvailableTimes.change_available_time(available_time)
    end
  end
end
