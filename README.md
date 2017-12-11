# ExInsightsLogger

Elixir custom Logger that automatically uploads your application logs on Azure Application Insights.

## Installation

Install from hex by adding `ex_insights` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ex_insights_logger, "~> 0.1"}
  ]
end
```

## Configuration

The `ExInsightsLogger` uses `ExInsights`, so the same configuration instructions apply here as well.

For more information, visit [ExInsights](https://hexdocs.pm/ex_insights/ExInsights.html).

Apart from the ExInsights configuration, you also need to set up your `config.exs` file as follows:

```elixir
config :logger,
  backends: [ExInsightsLogger],
```

You can choose specific fields to be in the metadata, by explicitly including them in the `config.exs`:

```elixir
config :logger,
  backends: [ExInsightsLogger],
  metadata: [:function, :pid, :stack_trace],
```

![additional meta](/screenshots/custom_meta_filter.PNG?raw=true)

For more information configuring the backends, visit [`Logger Backends`](https://hexdocs.pm/logger/Logger.html#module-backends).

## Usage

### Basic Usage

```elixir
# will log an informational message
Logger.log_info("<your message>")

# will produce a warning message
Logger.log_warn("<your message>")

# will raise an error message
Logger.log_error("<your message>")

# will produce a message for debugging purposes
Logger.debug("<your message>")
```

### Advanced Usage

In order to add metadata, you can follow the example below:

```elixir
Logger.log_info("<your message>", [custom: metadata])
```

![additional meta](/screenshots/additional_meta.PNG?raw=true)

In order to include an Erlang `stacktrace`, the `handle_at` variable and a `measurements` map,  you can follow the example below:

```elixir
Logger.log_error("<your message>", [stack_trace: :erlang.get_stacktrace, handle_at: "your_handle_at", measurements: %{"test" => 11}])
```

![additional meta](/screenshots/additional_error.PNG?raw=true)

![additional meta](/screenshots/stacktrace.PNG?raw=true)
