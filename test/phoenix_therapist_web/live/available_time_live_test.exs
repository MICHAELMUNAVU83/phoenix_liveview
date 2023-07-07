defmodule PhoenixTherapistWeb.AvailableTimeLiveTest do
  use PhoenixTherapistWeb.ConnCase

  import Phoenix.LiveViewTest
  import PhoenixTherapist.AvailableTimesFixtures

  @create_attrs %{date: %{day: 6, month: 7, year: 2023}, time: "some time"}
  @update_attrs %{date: %{day: 7, month: 7, year: 2023}, time: "some updated time"}
  @invalid_attrs %{date: %{day: 30, month: 2, year: 2023}, time: nil}

  defp create_available_time(_) do
    available_time = available_time_fixture()
    %{available_time: available_time}
  end

  describe "Index" do
    setup [:create_available_time]

    test "lists all available_times", %{conn: conn, available_time: available_time} do
      {:ok, _index_live, html} = live(conn, Routes.available_time_index_path(conn, :index))

      assert html =~ "Listing Available times"
      assert html =~ available_time.time
    end

    test "saves new available_time", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.available_time_index_path(conn, :index))

      assert index_live |> element("a", "New Available time") |> render_click() =~
               "New Available time"

      assert_patch(index_live, Routes.available_time_index_path(conn, :new))

      assert index_live
             |> form("#available_time-form", available_time: @invalid_attrs)
             |> render_change() =~ "is invalid"

      {:ok, _, html} =
        index_live
        |> form("#available_time-form", available_time: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.available_time_index_path(conn, :index))

      assert html =~ "Available time created successfully"
      assert html =~ "some time"
    end

    test "updates available_time in listing", %{conn: conn, available_time: available_time} do
      {:ok, index_live, _html} = live(conn, Routes.available_time_index_path(conn, :index))

      assert index_live
             |> element("#available_time-#{available_time.id} a", "Edit")
             |> render_click() =~
               "Edit Available time"

      assert_patch(index_live, Routes.available_time_index_path(conn, :edit, available_time))

      assert index_live
             |> form("#available_time-form", available_time: @invalid_attrs)
             |> render_change() =~ "is invalid"

      {:ok, _, html} =
        index_live
        |> form("#available_time-form", available_time: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.available_time_index_path(conn, :index))

      assert html =~ "Available time updated successfully"
      assert html =~ "some updated time"
    end

    test "deletes available_time in listing", %{conn: conn, available_time: available_time} do
      {:ok, index_live, _html} = live(conn, Routes.available_time_index_path(conn, :index))

      assert index_live
             |> element("#available_time-#{available_time.id} a", "Delete")
             |> render_click()

      refute has_element?(index_live, "#available_time-#{available_time.id}")
    end
  end

  describe "Show" do
    setup [:create_available_time]

    test "displays available_time", %{conn: conn, available_time: available_time} do
      {:ok, _show_live, html} =
        live(conn, Routes.available_time_show_path(conn, :show, available_time))

      assert html =~ "Show Available time"
      assert html =~ available_time.time
    end

    test "updates available_time within modal", %{conn: conn, available_time: available_time} do
      {:ok, show_live, _html} =
        live(conn, Routes.available_time_show_path(conn, :show, available_time))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Available time"

      assert_patch(show_live, Routes.available_time_show_path(conn, :edit, available_time))

      assert show_live
             |> form("#available_time-form", available_time: @invalid_attrs)
             |> render_change() =~ "is invalid"

      {:ok, _, html} =
        show_live
        |> form("#available_time-form", available_time: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.available_time_show_path(conn, :show, available_time))

      assert html =~ "Available time updated successfully"
      assert html =~ "some updated time"
    end
  end
end
