defmodule CheckListApi.Repo.Migrations.CreateItem do
  use Ecto.Migration

  def change do
    create table(:items) do
      add :name, :string
      add :completed, :boolean
      add :checklist_id, references(:checklists)      

      timestamps()
    end

  end
end
