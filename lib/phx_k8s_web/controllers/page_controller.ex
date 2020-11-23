defmodule PhxK8sWeb.PageController do
  use PhxK8sWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
