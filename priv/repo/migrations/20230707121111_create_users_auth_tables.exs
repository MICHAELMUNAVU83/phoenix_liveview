defmodule PhoenixTherapist.Repo.Migrations.CreateUsersAuthTables do
  use Ecto.Migration

  def change do
    execute "CREATE EXTENSION IF NOT EXISTS citext", ""

    create table(:users) do
      add(:email, :citext, null: false)
      add(:hashed_password, :string, null: false)
      add(:gender, :string, null: false)
      add(:first_name, :string, null: false)
      add(:last_name, :string, null: false)
      add(:phone_number, :string, null: false)
      add(:place_of_residence, :string, null: false)
      add(:date_of_birth, :string, null: false)
      add(:role, :string, null: false, default: "user")
      add(:county, :string, null: false)
      add(:marital_status, :string, null: false)
      add(:id_number, :integer, null: false)
      add(:occupation, :string, null: false)
      add(:confirmed_at, :naive_datetime)
      timestamps()
    end

    create(unique_index(:users, [:email]))

    create table(:users_tokens) do
      add(:user_id, references(:users, on_delete: :delete_all), null: false)
      add(:token, :binary, null: false)
      add(:context, :string, null: false)
      add(:sent_to, :string)
      timestamps(updated_at: false)
    end

    create(index(:users_tokens, [:user_id]))
    create(unique_index(:users_tokens, [:context, :token]))
  end
end
