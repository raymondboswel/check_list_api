defmodule CheckListApi.Item do
  use CheckListApi.Web, :model

  schema "items" do
    field :name, :string
    field :completed, :boolean
    field :sequence_number, :integer
    belongs_to :checklist, CheckListApi.Checklist
    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :checklist_id, :completed, :sequence_number])
    |> validate_required([:name])
  end
end