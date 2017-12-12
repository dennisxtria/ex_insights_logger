defmodule ExInsightsLogger do
  @moduledoc """
  This is a Logger module, using ExInsights to receive different kinds of logs
  and output them with the proper track method to Azure.

  This module has the following functions: `init/1`, `handle_event/2`.
  """
  use GenEvent

  @typedoc """
  Measurement name. Will be used extensively in the app insights UI
  """
  @type name :: String.t

  @typedoc """
  Defines the level of severity for the event.
  """
  @type severity_level :: :verbose | :info | :warning | :error | :critical

  @typedoc """
  Defines the type of the event metadata.
  """
  @type metadata :: keyword

  @typedoc """
  Represents the exception's stack trace.
  """
  @type stack_trace :: [stack_trace_entry]
  @type stack_trace_entry ::
        {module, atom, arity_or_args, location} |
        {(... -> any), arity_or_args, location}
  @typep arity_or_args :: non_neg_integer | list
  @typep location :: keyword

  @doc """
  Initializes the GenEvent for the Logger.
  """
  @spec init(name :: name) :: {:ok, map}
  def init(name) do
    {:ok, %{name: name, config: []}}
  end

  @doc """
  Waits for a log event to be triggered and sends the data to the track method accordingly.
  """
  def handle_event({severity_level, _gl, {_Logger, message, _timestamp, metadata}}, state) do
    metadata
    |> filter_metadata()
    |> track(severity_level, message)

    {:ok, state}
  end

  @spec track(metadata :: metadata, severity_level :: severity_level, binary() | fun()) :: :ok
  defp track(metadata, severity_level, message)
  defp track(metadata, :error, message) do
    with \
      nil <- metadata[:stack_trace]
    do
      ExInsights.track_trace(message, :error, fix(metadata))
    else
      _ -> ExInsights.track_exception(message, stacktrace_to_string(metadata[:stack_trace]), metadata[:handle_at] || nil, fix(metadata), metadata[:measurements] || %{})
    end
  end
  defp track(metadata, severity_level, message) do
    ExInsights.track_trace(message, severity_level, fix(metadata))
  end

  #converts the file value of the stacktrace from charlist to string
  @spec stacktrace_to_string(stack_trace :: stack_trace) :: keyword
  defp stacktrace_to_string(stacktrace) do
    Enum.map(stacktrace, fn {module, function, arity, [file: file, line: line]} -> {module, function, arity, [file: to_string(file), line: line]} end)
  end

  #filters metadata to return only the fields which are in the config
  @spec filter_metadata(metadata :: metadata) :: keyword
  defp filter_metadata(metadata) do
    Application.get_env(:logger, :metadata)
    |> Enum.map(fn x -> {x, metadata[x]} end)
    |> Enum.filter(fn {_, b} -> b != nil end)
  end

  #converts metadata key-value pairs to string and then, into a map
  @spec fix(metadata :: metadata) :: map
  defp fix(metadata) do
    metadata
    |> Enum.map(fn {key, value} -> {to_string(key), formatter(value)} end)
    |> Enum.into(%{})
  end

  #formats a given value to string properly
  @spec formatter(any) :: String.t
  defp formatter(value) when is_binary(value), do: value
  defp formatter(value) when is_atom(value), do: Atom.to_string(value)
  defp formatter(value), do: inspect(value)

end
