use Mix.Config

config :logger,
  backends: [:console, AriadneLogger],
  format: "\n$time $metadata[$level] $levelpad$message\n",
  metadata: [:user_id]
