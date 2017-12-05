defmodule ExInsightsLoggerTest do
  require Logger
  require ExInsights.TestHelper
  
  use ExUnit.Case
  
  alias ExInsights.TestHelper

  setup_all do
    Application.put_env(:ex_insights, :instrumentation_key, TestHelper.get_test_key)
  end

  TestHelper.setup_test_client

  test "test info" do
    message = "info"
    Logger.info(message)
    ExInsights.Aggregation.Worker.flush()
    receive do
      {:items_sent, [%{data: %{baseData: %{message: message2}}}]} -> assert message2 == message
    end
  end

  test "test debug" do
    message = "Test debug"
    value = 11
    Logger.debug(message, [value: value])
    ExInsights.Aggregation.Worker.flush()
    receive do
      {:items_sent, [%{data: %{baseData: %{metrics: [metrics]}}}]} -> assert (metrics[:name] == message && metrics[:value] == value)
     end
  end

  test "test warn" do
    message = "warn"
    Logger.warn(message)
    ExInsights.Aggregation.Worker.flush()
    receive do
      {:items_sent, [%{data: %{baseData: %{message: message2}}}]} -> assert message2 == message
    end
  end

  test "test error" do
    message = "test error message"
    Logger.error(message)
    ExInsights.Aggregation.Worker.flush()
    receive do
      {:items_sent, [%{data: %{baseData: %{exceptions: [exceptions]}}}]} -> assert exceptions[:message] == message
    end
  end

end