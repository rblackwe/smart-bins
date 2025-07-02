defmodule SmartBins.AWS do
  @moduledoc """
  AWS S3 integration for fetching bin images.
  """

  alias ExAws.S3

  @bucket Application.compile_env(:smart_bins, :s3_bucket, "smart-bins-images")

  @doc """
  Gets the thumbnail URL for a bin (index.png).

  ## Examples

      iex> get_thumbnail_url(1, 24)
      "https://s3.amazonaws.com/smart-bins-images/1/24/index.png"
      
  """
  def get_thumbnail_url(container_id, bin_id) do
    key = "#{container_id}/#{bin_id}/index.png"
    ExAws.S3.presigned_url(:get, @bucket, key, expires_in: 3600)
  end

  @doc """
  Lists all images for a specific bin.

  ## Examples

      iex> list_bin_images(1, 24)
      {:ok, ["index.png", "detail1.jpg", "detail2.jpg"]}
      
  """
  def list_bin_images(container_id, bin_id) do
    prefix = "#{container_id}/#{bin_id}/"

    case S3.list_objects_v2(@bucket, prefix: prefix) |> ExAws.request() do
      {:ok, %{body: %{contents: contents}}} ->
        images =
          contents
          |> Enum.map(& &1.key)
          |> Enum.filter(&String.ends_with?(&1, [".png", ".jpg", ".jpeg"]))
          |> Enum.map(&Path.basename/1)

        {:ok, images}

      {:error, reason} ->
        {:error, reason}
    end
  end

  @doc """
  Checks if a bin has an index.png thumbnail.

  ## Examples

      iex> has_thumbnail?(1, 24)
      true
      
  """
  def has_thumbnail?(container_id, bin_id) do
    key = "#{container_id}/#{bin_id}/index.png"

    case S3.head_object(@bucket, key) |> ExAws.request() do
      {:ok, _} -> true
      {:error, _} -> false
    end
  end

  @doc """
  Gets the raw image data for analysis.

  ## Examples

      iex> get_image_data(1, 24, "index.png")
      {:ok, <<binary_data>>}
      
  """
  def get_image_data(container_id, bin_id, filename) do
    key = "#{container_id}/#{bin_id}/#{filename}"

    case S3.get_object(@bucket, key) |> ExAws.request() do
      {:ok, %{body: body}} -> {:ok, body}
      {:error, reason} -> {:error, reason}
    end
  end
end
