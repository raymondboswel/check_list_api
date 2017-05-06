defmodule CheckListApi.Item do
  use CheckListApi.Web, :model

  schema "items" do
    field :name, :string
    field :completed, :boolean
    belongs_to :checklist, CheckListApi.Checklist
    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :checklist_id, :completed])
    |> validate_required([:name])
  end
end