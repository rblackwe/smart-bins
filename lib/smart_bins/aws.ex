defmodule SmartBins.FileSystem do
  @moduledoc """
  Local filesystem module for reading bin images from priv/static/bin_images/
  """

  @doc """
  Gets image data from local filesystem at path:
  priv/static/bin_images/{container_id}/{bin_id}/{filename}
  """
  def get_image_data(container_id, bin_id, filename) do
    image_path =
      Path.join([
        Application.app_dir(:smart_bins, "priv/static/bin_images"),
        to_string(container_id),
        to_string(bin_id),
        filename
      ])

    case File.read(image_path) do
      {:ok, image_data} ->
        {:ok, image_data}

      {:error, :enoent} ->
        # Create a placeholder image if file doesn't exist
        create_placeholder_image(container_id, bin_id, filename)

      {:error, reason} ->
        {:error, "Failed to read image file: #{reason}"}
    end
  end

  @doc """
  Creates a placeholder image for demo purposes
  """
  defp create_placeholder_image(container_id, bin_id, filename) do
    # Create directory structure if it doesn't exist
    dir_path =
      Path.join([
        Application.app_dir(:smart_bins, "priv/static/bin_images"),
        to_string(container_id),
        to_string(bin_id)
      ])

    File.mkdir_p!(dir_path)

    # Create a simple placeholder image (SVG for demo)
    placeholder_svg = """
    <svg width="400" height="300" xmlns="http://www.w3.org/2000/svg">
      <rect width="400" height="300" fill="#374151"/>
      <text x="200" y="130" font-family="monospace" font-size="16" fill="#9CA3AF" text-anchor="middle">
        BIN #{container_id}.#{bin_id}
      </text>
      <text x="200" y="160" font-family="monospace" font-size="12" fill="#6B7280" text-anchor="middle">
        Demo Image
      </text>
      <text x="200" y="180" font-family="monospace" font-size="12" fill="#6B7280" text-anchor="middle">
        #{filename}
      </text>
    </svg>
    """

    image_path = Path.join(dir_path, filename)
    File.write!(image_path, placeholder_svg)

    {:ok, placeholder_svg}
  end

  @doc """
  Gets the URL path for serving images via Phoenix static plug
  """
  def get_image_url(container_id, bin_id, filename) do
    "/bin_images/#{container_id}/#{bin_id}/#{filename}"
  end

  @doc """
  Lists all image files for a given bin
  """
  def list_bin_images(container_id, bin_id) do
    image_dir =
      Path.join([
        Application.app_dir(:smart_bins, "priv/static/bin_images"),
        to_string(container_id),
        to_string(bin_id)
      ])

    case File.ls(image_dir) do
      {:ok, files} ->
        {:ok, Enum.filter(files, &String.ends_with?(&1, [".png", ".jpg", ".jpeg", ".svg"]))}

      {:error, :enoent} ->
        {:ok, []}

      {:error, reason} ->
        {:error, reason}
    end
  end
end
