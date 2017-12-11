defmodule ExInsightsLogger do
  @moduledoc """
  This is a Logger module, using ExInsights to receive different kinds of logs
  and output them with the proper track method to Azure.

  This module has the following functions: `init/1`, `handle_event/2`.
  """
  use GenEvent

  @doc """
  Initializes the GenEvent for the Logger.
  """
  def init(name), do: {:ok, %{name: name, config: []}}

  @doc """
  Waits for a log event to be triggered and sends the data to the track method accordingly.
  """
  def handle_event({level, _gl, {_Logger, msg, _timestamp, metadata}}, state) do
    metadata
    |> filter_metadata()
    |> track(level, msg)

    {:ok, state}
  end

  defp track(metadata, :error, msg) do
    with \
      nil <- metadata[:stack_trace]
    do
      ExInsights.track_trace(msg, :error, fix(metadata))
    else
      _ -> ExInsights.track_exception(msg, stacktrace_file_to_string(metadata[:stack_trace]), metadata[:handle_at] || nil, fix(metadata), metadata[:measurements] || %{})
    end
  end
  defp track(metadata, level, msg) do
    ExInsights.track_trace(msg, level, fix(metadata))
  end

  #converts the file value of the stacktrace from charlist to string
  defp stacktrace_file_to_string(stacktrace) do
    Enum.map(stacktrace, fn {module, function, arity, [file: file, line: line]} -> {module, function, arity, [file: to_string(file), line: line]} end)
  end

  #filters metadata to return only the fields which are in the config
  defp filter_metadata(metadata) do
    Application.get_env(:logger, :metadata)
    |> Enum.map(fn x -> {x, metadata[x]} end)
    |> Enum.filter(fn {_, b} -> b != nil end)
  end

  #converts metadata key-value pairs to string and then, into a map
  defp fix(metadata) do
    metadata
    |> Enum.map(fn {key, value} -> {to_string(key), formatter(value)} end)
    |> Enum.into(%{})
  end

  #formats a given value to string properly
  defp formatter(value) when is_binary(value), do: value
  defp formatter(value) when is_atom(value), do: Atom.to_string(value)
  defp formatter(value), do: inspect(value)

end
