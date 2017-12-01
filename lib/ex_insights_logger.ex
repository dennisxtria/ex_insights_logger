defmodule ExInsightsLogger do
  use GenEvent

  def init(name) do
    {:ok, %{name: name, config: []}}
  end

  def handle_event({level, _gl, {_Logger, msg, timestamp, metadata}}, state) do
    event = %{timestamp: inspect(timestamp), message: msg, metadata: inspect(metadata)}

    case level do
      :info -> ExInsights.track_trace(msg, level, %{"metadata" => inspect(metadata)})
      :debug -> ExInsights.track_event(msg, %{"metadata" => inspect(metadata)})
      :warn -> ExInsights.track_trace(msg, level, %{"metadata" => inspect(metadata)})
      :error -> ExInsights.track_exception(msg, :erlang.get_stacktrace, nil, %{"metadata" => inspect(metadata)})
    end  
    {:ok, state}
  end
end
