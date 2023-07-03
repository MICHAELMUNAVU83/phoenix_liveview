defmodule PhoenixTherapistWeb.PageController do
  use PhoenixTherapistWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
