defmodule CheckListApi.Repo.Migrations.CreateProject do
  use Ecto.Migration

  def change do
    create unique_index(:projects, [:name])

  end
end
