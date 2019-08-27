defmodule ClockWeb.PageController do
  use ClockWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
