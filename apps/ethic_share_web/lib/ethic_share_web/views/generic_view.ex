defmodule EthicShareWeb.GenericView do
  use EthicShareWeb, :view

  def render("code.json", %{code: code}) do
    %{code: code}
  end
end
