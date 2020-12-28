defmodule EthicShareWeb.TokenPlug do
  import Plug.Conn
  import Phoenix.Controller
  import EthicShareWeb.Helpers
  import EthicShareWeb.JwtToken
  import EthicShareWeb.PlugHelpers

  def init(default), do: default

  def call(conn, _default), do: call_impl(conn, false)
end
