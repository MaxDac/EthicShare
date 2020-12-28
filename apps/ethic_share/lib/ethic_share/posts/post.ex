defmodule EthicShare.Posts.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field :tags, {:array, :string}
    field :text, :string
    field :title, :string
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:title, :text, :tags])
    |> validate_required([:title, :text, :tags])
  end
end
