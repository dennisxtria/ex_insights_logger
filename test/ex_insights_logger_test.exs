defmodule ExInsightsLoggerTest do
  require Logger
  use ExUnit.Case
  use Plug
  #doctest ExInsightsLogger

  Logger.add_backend({AriadneLogger, :test_logger})

  setup do
    Plug.Adapters.Cowboy.child_spec(:http, MyRouter, [], [port: 4001])

    post "/test" do
      send_resp(conn, status, conn.body_params)
    end
  end

  test "tests " do
    Logger.info("test")

  end

end
