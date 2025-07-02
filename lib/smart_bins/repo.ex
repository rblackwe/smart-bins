defmodule SmartBins.Repo do
  use Ecto.Repo,
    otp_app: :smart_bins,
    adapter: Ecto.Adapters.SQLite3
end
