defmodule CheckListApi.Repo.Migrations.CreateChecklist do
  use Ecto.Migration

  def change do
    create table(:checklists) do
      add :name, :string
      add :project_id, references(:projects)      

      timestamps()
    end

  end
end
