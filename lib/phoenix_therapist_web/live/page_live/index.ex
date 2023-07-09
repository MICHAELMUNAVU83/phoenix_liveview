defmodule PhoenixTherapistWeb.PageLive.Index do
  use PhoenixTherapistWeb, :live_view
  alias PhoenixTherapist.Accounts

  def mount(_params, session, socket) do
    if session["user_token"] != nil do
      user = Accounts.get_user_by_session_token(session["user_token"])

      {:ok,
       socket
       |> assign(:page_title, "Home")
       |> assign(:user, user)}
    else
      {:ok,
       socket
       |> assign(:page_title, "Home")
       |> assign(:user, nil)}
    end
  end
end
