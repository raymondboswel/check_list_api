defmodule CheckListApi.User do
  use CheckListApi.Web, :model
  require Logger

  schema "users" do
    field :first_name, :string
    field :last_name, :string
    field :email, :string
    field :passwd_hash, :string
    has_many :projects, CheckListApi.Project
    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    Logger.debug "struct: #{inspect struct}"
    Logger.debug "params: #{inspect params}"
    struct
    |> cast(params, [:first_name, :last_name, :email, :passwd_hash])
    |> validate_required([:first_name, :last_name])
    |> unique_constraint(:email)
  end
end
