defmodule ExInsightsLogger do
  use GenEvent

  def init(name) do
    {:ok, %{name: name, config: []}}
  end

  def handle_event({level, _gl, {_Logger, msg, timestamp, metadata}}, state) do
    event =  "CUSTOM LOGGER BACKEND: [#{level}, #{inspect(timestamp)}, #{msg}, #{inspect(metadata)}]"
    IO.inspect event
    #todo call ex_insights function to send the event!
    {:ok, state}
  end
end
