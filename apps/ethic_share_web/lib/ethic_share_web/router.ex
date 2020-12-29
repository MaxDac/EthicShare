defmodule EthicShareWeb.Router do
  use EthicShareWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", EthicShareWeb do
    pipe_through :api

    get "/users", UserController, :index
    get "/user/:id", UserController, :show
    post "/user", UserController, :create

    post "/authenticate", AuthenticationController, :authenticate

    get "/posts", PostController, :index
    get "/post/:id", PostController, :show
  end
end
