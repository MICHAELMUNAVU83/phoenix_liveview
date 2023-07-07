defmodule PhoenixTherapist.BookingsTest do
  use PhoenixTherapist.DataCase

  alias PhoenixTherapist.Bookings

  describe "bookings" do
    alias PhoenixTherapist.Bookings.Booking

    import PhoenixTherapist.BookingsFixtures

    @invalid_attrs %{counselor_gender_preference: nil, counsulted_before: nil, medical_history: nil, next_of_kin_name: nil, next_of_kin_number: nil, referred_by: nil, visit: nil}

    test "list_bookings/0 returns all bookings" do
      booking = booking_fixture()
      assert Bookings.list_bookings() == [booking]
    end

    test "get_booking!/1 returns the booking with given id" do
      booking = booking_fixture()
      assert Bookings.get_booking!(booking.id) == booking
    end

    test "create_booking/1 with valid data creates a booking" do
      valid_attrs = %{counselor_gender_preference: "some counselor_gender_preference", counsulted_before: "some counsulted_before", medical_history: "some medical_history", next_of_kin_name: "some next_of_kin_name", next_of_kin_number: "some next_of_kin_number", referred_by: "some referred_by", visit: "some visit"}

      assert {:ok, %Booking{} = booking} = Bookings.create_booking(valid_attrs)
      assert booking.counselor_gender_preference == "some counselor_gender_preference"
      assert booking.counsulted_before == "some counsulted_before"
      assert booking.medical_history == "some medical_history"
      assert booking.next_of_kin_name == "some next_of_kin_name"
      assert booking.next_of_kin_number == "some next_of_kin_number"
      assert booking.referred_by == "some referred_by"
      assert booking.visit == "some visit"
    end

    test "create_booking/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Bookings.create_booking(@invalid_attrs)
    end

    test "update_booking/2 with valid data updates the booking" do
      booking = booking_fixture()
      update_attrs = %{counselor_gender_preference: "some updated counselor_gender_preference", counsulted_before: "some updated counsulted_before", medical_history: "some updated medical_history", next_of_kin_name: "some updated next_of_kin_name", next_of_kin_number: "some updated next_of_kin_number", referred_by: "some updated referred_by", visit: "some updated visit"}

      assert {:ok, %Booking{} = booking} = Bookings.update_booking(booking, update_attrs)
      assert booking.counselor_gender_preference == "some updated counselor_gender_preference"
      assert booking.counsulted_before == "some updated counsulted_before"
      assert booking.medical_history == "some updated medical_history"
      assert booking.next_of_kin_name == "some updated next_of_kin_name"
      assert booking.next_of_kin_number == "some updated next_of_kin_number"
      assert booking.referred_by == "some updated referred_by"
      assert booking.visit == "some updated visit"
    end

    test "update_booking/2 with invalid data returns error changeset" do
      booking = booking_fixture()
      assert {:error, %Ecto.Changeset{}} = Bookings.update_booking(booking, @invalid_attrs)
      assert booking == Bookings.get_booking!(booking.id)
    end

    test "delete_booking/1 deletes the booking" do
      booking = booking_fixture()
      assert {:ok, %Booking{}} = Bookings.delete_booking(booking)
      assert_raise Ecto.NoResultsError, fn -> Bookings.get_booking!(booking.id) end
    end

    test "change_booking/1 returns a booking changeset" do
      booking = booking_fixture()
      assert %Ecto.Changeset{} = Bookings.change_booking(booking)
    end
  end
end
