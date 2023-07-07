defmodule PhoenixTherapistWeb.BookingLiveTest do
  use PhoenixTherapistWeb.ConnCase

  import Phoenix.LiveViewTest
  import PhoenixTherapist.BookingsFixtures

  @create_attrs %{
    counselor_gender_preference: "some counselor_gender_preference",
    counsulted_before: "some counsulted_before",
    medical_history: "some medical_history",
    next_of_kin_name: "some next_of_kin_name",
    next_of_kin_number: "some next_of_kin_number",
    referred_by: "some referred_by",
    visit: "some visit"
  }
  @update_attrs %{
    counselor_gender_preference: "some updated counselor_gender_preference",
    counsulted_before: "some updated counsulted_before",
    medical_history: "some updated medical_history",
    next_of_kin_name: "some updated next_of_kin_name",
    next_of_kin_number: "some updated next_of_kin_number",
    referred_by: "some updated referred_by",
    visit: "some updated visit"
  }
  @invalid_attrs %{
    counselor_gender_preference: nil,
    counsulted_before: nil,
    medical_history: nil,
    next_of_kin_name: nil,
    next_of_kin_number: nil,
    referred_by: nil,
    visit: nil
  }

  defp create_booking(_) do
    booking = booking_fixture()
    %{booking: booking}
  end

  describe "Index" do
    setup [:create_booking]

    test "lists all bookings", %{conn: conn, booking: booking} do
      {:ok, _index_live, html} = live(conn, Routes.booking_index_path(conn, :index))

      assert html =~ "Listing Bookings"
      assert html =~ booking.counselor_gender_preference
    end

    test "saves new booking", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.booking_index_path(conn, :index))

      assert index_live |> element("a", "New Booking") |> render_click() =~
               "New Booking"

      assert_patch(index_live, Routes.booking_index_path(conn, :new))

      assert index_live
             |> form("#booking-form", booking: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#booking-form", booking: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.booking_index_path(conn, :index))

      assert html =~ "Booking created successfully"
      assert html =~ "some counselor_gender_preference"
    end

    test "updates booking in listing", %{conn: conn, booking: booking} do
      {:ok, index_live, _html} = live(conn, Routes.booking_index_path(conn, :index))

      assert index_live |> element("#booking-#{booking.id} a", "Edit") |> render_click() =~
               "Edit Booking"

      assert_patch(index_live, Routes.booking_index_path(conn, :edit, booking))

      assert index_live
             |> form("#booking-form", booking: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#booking-form", booking: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.booking_index_path(conn, :index))

      assert html =~ "Booking updated successfully"
      assert html =~ "some updated counselor_gender_preference"
    end

    test "deletes booking in listing", %{conn: conn, booking: booking} do
      {:ok, index_live, _html} = live(conn, Routes.booking_index_path(conn, :index))

      assert index_live |> element("#booking-#{booking.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#booking-#{booking.id}")
    end
  end

  describe "Show" do
    setup [:create_booking]

    test "displays booking", %{conn: conn, booking: booking} do
      {:ok, _show_live, html} = live(conn, Routes.booking_show_path(conn, :show, booking))

      assert html =~ "Show Booking"
      assert html =~ booking.counselor_gender_preference
    end

    test "updates booking within modal", %{conn: conn, booking: booking} do
      {:ok, show_live, _html} = live(conn, Routes.booking_show_path(conn, :show, booking))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Booking"

      assert_patch(show_live, Routes.booking_show_path(conn, :edit, booking))

      assert show_live
             |> form("#booking-form", booking: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#booking-form", booking: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.booking_show_path(conn, :show, booking))

      assert html =~ "Booking updated successfully"
      assert html =~ "some updated counselor_gender_preference"
    end
  end
end
