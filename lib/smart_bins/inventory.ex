defmodule SmartBins.Inventory.Bin do
  use Ecto.Schema
  import Ecto.Changeset

  alias SmartBins.Inventory.{Tag, BinTag}

  schema "bins" do
    field :container_id, :integer
    field :bin_id, :integer
    field :description, :string
    field :ai_description, :string
    field :thumbnail_url, :string
    field :status, :string, default: "empty"
    field :last_scanned_at, :naive_datetime
    field :notes, :string

    many_to_many :tags, Tag, join_through: BinTag, on_replace: :delete

    timestamps()
  end

  @doc false
  def changeset(bin, attrs) do
    bin
    |> cast(attrs, [
      :container_id,
      :bin_id,
      :description,
      :ai_description,
      :thumbnail_url,
      :status,
      :last_scanned_at,
      :notes
    ])
    |> validate_required([:container_id, :bin_id])
    |> validate_inclusion(:status, ["empty", "partial", "full"])
    |> unique_constraint([:container_id, :bin_id])
  end
end

defmodule SmartBins.Inventory.Tag do
  use Ecto.Schema
  import Ecto.Changeset

  alias SmartBins.Inventory.{Bin, BinTag}

  schema "tags" do
    field :name, :string
    field :color, :string, default: "#065f46"

    many_to_many :bins, Bin, join_through: BinTag

    timestamps()
  end

  @doc false
  def changeset(tag, attrs) do
    tag
    |> cast(attrs, [:name, :color])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end
end

defmodule SmartBins.Inventory.BinTag do
  use Ecto.Schema

  alias SmartBins.Inventory.{Bin, Tag}

  schema "bin_tags" do
    belongs_to :bin, Bin
    belongs_to :tag, Tag

    timestamps()
  end
end

defmodule SmartBins.Inventory do
  @moduledoc """
  The Inventory context.
  """

  import Ecto.Query, warn: false
  alias SmartBins.Repo

  alias SmartBins.Inventory.{Bin, Tag}

  @doc """
  Returns the list of bins.

  ## Examples

      iex> list_bins()
      [%Bin{}, ...]

  """
  def list_bins do
    Repo.all(Bin)
    |> Repo.preload([:tags])
  end

  @doc """
  Gets a single bin.

  Raises `Ecto.NoResultsError` if the Bin does not exist.

  ## Examples

      iex> get_bin!(123)
      %Bin{}

      iex> get_bin!(456)
      ** (Ecto.NoResultsError)

  """
  def get_bin!(id), do: Repo.get!(Bin, id) |> Repo.preload([:tags])

  @doc """
  Gets a bin by container_id and bin_id.

  ## Examples

      iex> get_bin_by_container_and_bin(1, 24)
      %Bin{}

  """
  def get_bin_by_container_and_bin(container_id, bin_id) do
    Repo.get_by(Bin, container_id: container_id, bin_id: bin_id)
    |> case do
      nil -> nil
      bin -> Repo.preload(bin, [:tags])
    end
  end

  @doc """
  Creates a bin.

  ## Examples

      iex> create_bin(%{field: value})
      {:ok, %Bin{}}

      iex> create_bin(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_bin(attrs \\ %{}) do
    %Bin{}
    |> Bin.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a bin.

  ## Examples

      iex> update_bin(bin, %{field: new_value})
      {:ok, %Bin{}}

      iex> update_bin(bin, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_bin(%Bin{} = bin, attrs) do
    bin
    |> Bin.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a bin.

  ## Examples

      iex> delete_bin(bin)
      {:ok, %Bin{}}

      iex> delete_bin(bin)
      {:error, %Ecto.Changeset{}}

  """
  def delete_bin(%Bin{} = bin) do
    Repo.delete(bin)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking bin changes.

  ## Examples

      iex> change_bin(bin)
      %Ecto.Changeset{}}

  """
  def change_bin(%Bin{} = bin, attrs \\ %{}) do
    Bin.changeset(bin, attrs)
  end

  @doc """
  Returns the list of tags.
  """
  def list_tags do
    Repo.all(Tag)
  end

  @doc """
  Creates a tag.
  """
  def create_tag(attrs \\ %{}) do
    %Tag{}
    |> Tag.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Finds or creates a tag by name.
  """
  def find_or_create_tag(name) do
    case Repo.get_by(Tag, name: name) do
      nil ->
        create_tag(%{name: name})

      tag ->
        {:ok, tag}
    end
  end
end
