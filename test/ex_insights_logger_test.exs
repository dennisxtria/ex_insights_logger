defmodule ExInsightsLoggerTest do
  require Logger
  use ExUnit.Case

  @service_url Application.get_env(:ex_insights_logger, :service_url)

  Logger.add_backend({AriadneLogger, :test_logger})

  setup_all do
    Code.require_file("test/test_router.ex")
    IO.inspect Code.ensure_compiled?(TestRouter) 
    {:ok, pid} = Plug.Adapters.Cowboy.http(TestRouter, [], [port: 4001])
    [pid: pid]
  end

  test "tests", context do
    # Logger.metadata(sender_pid: context[:pid]) 
    # Logger.level()
    # |> Logger.log("fsgfds", %{pid: result})
    #Logger.metadata([test_pid: pid])
    Logger.info("test")
    #assert_receive("What I sent")
    
  end

end
