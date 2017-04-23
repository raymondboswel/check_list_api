defmodule CheckListApi.Repo.Migrations.AddProjectUniqueConstraint do
  use Ecto.Migration

  def change do
    create unique_index(:projects, [:name])

  end
end
