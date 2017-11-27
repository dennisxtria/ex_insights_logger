defmodule ExInsightsLoggerTest do
  require Logger
  use ExUnit.Case
  #doctest ExInsightsLogger

  Logger.add_backend({AriadneLogger, :test_logger})

  test "tests " do
    {ok, Pid} = :inets.start(httpd, [{port, 0},
    {server_name,"httpd_test"}, {server_root,"/tmp"},
    {document_root,"/tmp/htdocs"}, {bind_address, "localhost"}]).
    {ok, "0.79.0"}
  end
end
