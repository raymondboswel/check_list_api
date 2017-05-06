defmodule CheckListApi.Checklist do
  use CheckListApi.Web, :model

  schema "checklists" do
    field :name, :string
    belongs_to :project, CheckListApi.Project
    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :project_id])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end
end
