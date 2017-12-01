defmodule ExInsightsLoggerTest do
  require Logger
  require ExInsights.TestHelper
  
  use ExUnit.Case
  
  alias ExInsights.TestHelper

  Logger.add_backend({ExInsightsLogger, :test_logger})

  setup_all do
    Application.put_env(:ex_insights, :instrumentation_key, TestHelper.get_test_key)
  end

  TestHelper.setup_test_client

  test "tests", _context do
    message = "This is a test"
    Logger.info(message)
    ExInsights.Aggregation.Worker.flush()
    receive do
      {:items_sent, [%{data: %{baseData: %{message: message2}}}]} -> assert message2[:message] == message
     end
    # IO.inspect message2, label: "Poutses"
    # assert message == %{message: "This is a test", timestamp: ""}
  end
end
