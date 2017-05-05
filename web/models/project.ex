defmodule CheckListApi.Project do
  use CheckListApi.Web, :model

  schema "projects" do
    field :name, :string
    has_many :checklists, CheckListApi.Checklist
    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end
end
