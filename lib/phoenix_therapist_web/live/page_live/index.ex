defmodule PhoenixTherapistWeb.PageLive.Index do
  use PhoenixTherapistWeb, :live_view
  alias PhoenixTherapist.Accounts

  def mount(_params, session, socket) do
    if session["user_token"] != nil do
      user = Accounts.get_user_by_session_token(session["user_token"])

      admin_user_emails = ["admin@gmail.com", "marierose.uwamhoro@icloud.com"]

      admin_users =
        Enum.any?(admin_user_emails, fn admin_user_email ->
          admin_user_email == user.email
        end)

      {:ok,
       socket
       |> assign(:page_title, "Home")
       |> assign(:admin_user, admin_users)
       |> assign(:user, user)}
    else
      {:ok,
       socket
       |> assign(:page_title, "Home")
       |> assign(:admin_user, false)
       |> assign(:user, nil)}
    end
  end
end
