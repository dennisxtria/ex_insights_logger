defmodule TestRouter do
  use Plug.Router
  plug :match
  plug :dispatch

  post "/test" do
    send(self(), conn.body_params)
    send_resp(conn, 200, conn.body_params)
  end
end