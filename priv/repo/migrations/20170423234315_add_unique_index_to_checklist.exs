defmodule CheckListApi.Repo.Migrations.AddUniqueConstraintToChecklist do
  use Ecto.Migration

  def change do
    create unique_index(:checklists, [:name])

  end
end
