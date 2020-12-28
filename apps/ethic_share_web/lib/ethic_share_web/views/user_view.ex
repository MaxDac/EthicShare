defmodule EthicShareWeb.UserView do
  use EthicShareWeb, :view
  alias EthicShareWeb.UserView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      username: user.username,
      avatar: user.avatar,
      description: user.description,
      admin: user.admin,
      email: user.email}
  end
end
