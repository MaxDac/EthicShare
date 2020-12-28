defmodule EthicShare.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :username, :string, unique: true
      add :avatar, :text
      add :description, :text
      add :password_hash, :text
      add :admin, :boolean, default: false, null: false
      add :email, :string, unique: true

      timestamps()
    end

    create unique_index(:users, :username, name: :user_username_uk)
    create unique_index(:users, :email, name: :user_email_uk)

  end
end
