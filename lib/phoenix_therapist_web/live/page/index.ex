defmodule PhoenixTherapistWeb.PageLive.Index do
  use PhoenixTherapistWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, :page_title, "Home")}
  end
end
