defmodule EthicShareWeb.AuthorizationPlug do
  import Plug.Conn
  import Phoenix.Controller
  import EthicShareWeb.Helpers
  import EthicShareWeb.JwtToken
  import EthicShareWeb.PlugHelpers

  @session_cookie_key "x-session-token"

  def init(default), do: default

  def call(conn, _default), do: call_impl(conn, true)
end
