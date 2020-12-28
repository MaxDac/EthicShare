defmodule EthicShare.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :admin, :boolean, default: false
    field :avatar, :string
    field :description, :string
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    field :username, :string

    timestamps()
  end

  def put_pass_hash(changeset) do
    case changeset do
      %Ecto.Changeset {
        valid?: true,
        changes: %{password: pass}
      } ->
        put_change(changeset, :password_hash, Pbkdf2.hash_pwd_salt(pass))
      _ -> changeset
    end
  end

  def update_changeset(user, params) do
    user
    |> changeset(params)
    |> cast(params, [:email])
    |> validate_required([:email])
  end

  def registration_changeset(user, params) do
    user
    |> changeset(params)
    |> cast(params, [:username, :email, :password])
    |> validate_required([:username, :email, :password])
    |> validate_length(:password, min: 6, max: 100)
    |> unique_constraint(:username, name: :user_username_uk)
    |> unique_constraint(:email, name: :user_email_uk)
    |> put_pass_hash()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :password, :email])
    |> validate_required([:username, :password, :email])
  end
end
