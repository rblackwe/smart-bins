defmodule SmartBins.Repo.Migrations.CreateBinsAndTags do
  use Ecto.Migration

  def change do
    create table(:bins) do
      add :container_id, :integer, null: false
      add :bin_id, :integer, null: false
      add :description, :string
      add :ai_description, :text
      add :thumbnail_url, :string
      add :status, :string, default: "empty"
      add :last_scanned_at, :naive_datetime
      add :notes, :text

      timestamps()
    end

    create table(:tags) do
      add :name, :string, null: false
      add :color, :string, default: "#065f46"

      timestamps()
    end

    create table(:bin_tags) do
      add :bin_id, references(:bins, on_delete: :delete_all), null: false
      add :tag_id, references(:tags, on_delete: :delete_all), null: false

      timestamps()
    end

    # Ensure unique container.bin combinations
    create unique_index(:bins, [:container_id, :bin_id])

    # Ensure unique tag names
    create unique_index(:tags, [:name])

    # Ensure unique bin-tag relationships
    create unique_index(:bin_tags, [:bin_id, :tag_id])

    # Index for efficient queries
    create index(:bins, [:status])
    create index(:bins, [:container_id])
    create index(:bins, [:last_scanned_at])
    create index(:bin_tags, [:bin_id])
    create index(:bin_tags, [:tag_id])
  end
end
