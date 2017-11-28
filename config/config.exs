use Mix.Config

config :ex_insights,
  instrumentation_key: "0000-1111-2222-3333",
  flush_interval_secs: 30


config :logger,
  backends: [:console, ExInsightsLogger],
  format: "\n$time $metadata[$level] $levelpad$message\n",
  metadata: [:user_id]

import_config "#{Mix.env}.exs"
