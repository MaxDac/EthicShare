defmodule EthicShare.Repo do
  use Ecto.Repo,
    otp_app: :ethic_share,
    adapter: Ecto.Adapters.Postgres
end
