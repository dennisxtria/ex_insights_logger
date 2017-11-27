defmodule ExInsightsLogger do
  @moduledoc """
  Documentation for ExInsightsLogger.
  """
  use GenEvent

  @doc """
  Hello world.

  ## Examples

      iex> ExInsightsLogger.hello
      :world

  """
  def init(name) do
    {:ok, %{name: name, config: []}}
  end

  def handle_event({level, _gl, {_Logger, msg, timestamp, _metadata}}, _state) do
    event = "CUSTOM LOGGER BACKEND: [#{level}, #{timestamp}, #{msg}]"
    {:ok, event}
  end
end
