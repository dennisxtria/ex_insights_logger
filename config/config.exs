use Mix.Config

config :ex_insights,
  instrumentation_key: "ed81f212-cefa-45a0-b88d-b19622693995"


config :logger,
  backends: [:console, ExInsightsLogger],
  format: "\n$time $metadata[$level] $levelpad$message\n",
  metadata: [:user_id]

#import_config "#{Mix.env}.exs"
