defmodule SmartBinsWeb.BinsLive do
  use SmartBinsWeb, :live_view

  alias SmartBins.Inventory
  alias SmartBins.AWS
  alias SmartBins.AI

  @impl true
  def mount(_params, _session, socket) do
    if connected?(socket) do
      Phoenix.PubSub.subscribe(SmartBins.PubSub, "bins")
    end

    bins = Inventory.list_bins()

    {:ok,
     socket
     |> assign(:bins_empty?, bins == [])
     |> assign(:selected_bin, nil)
     |> assign(:search_term, "")
     |> assign(:status_filter, "all")
     |> assign(:container_filter, "all")
     |> stream(:bins, bins)}
  end

  @impl true
  def handle_event("select_bin", %{"id" => bin_id}, socket) do
    bin = Inventory.get_bin!(bin_id)
    {:noreply, assign(socket, :selected_bin, bin)}
  end

  @impl true
  def handle_event(
        "filter",
        %{"search" => search, "status" => status, "container" => container},
        socket
      ) do
    bins = filter_bins(search, status, container)

    {:noreply,
     socket
     |> assign(:search_term, search)
     |> assign(:status_filter, status)
     |> assign(:container_filter, container)
     |> assign(:bins_empty?, bins == [])
     |> stream(:bins, bins, reset: true)}
  end

  @impl true
  def handle_event("scan_bin", %{"id" => bin_id}, socket) do
    bin = Inventory.get_bin!(bin_id)

    case AWS.get_image_data(bin.container_id, bin.bin_id, "index.png") do
      {:ok, image_data} ->
        case AI.analyze_bin_image(image_data) do
          {:ok, ai_description} ->

            {:ok, updated_bin} =
              Inventory.update_bin(bin, %{
                ai_description: ai_description,
                last_scanned_at: NaiveDateTime.utc_now()
              })

            Phoenix.PubSub.broadcast(SmartBins.PubSub, "bins", {:bin_updated, updated_bin})

            {:noreply,
             socket
             |> put_flash(:info, "Bin #{bin.container_id}.#{bin.bin_id} scanned successfully!")
             |> stream_insert(:bins, updated_bin)}

          {:error, reason} ->
            {:noreply, put_flash(socket, :error, "AI analysis failed: #{reason}")}
        end

      {:error, reason} ->
        {:noreply, put_flash(socket, :error, "Failed to get image: #{reason}")}
    end
  end

  @impl true
  def handle_info({:bin_updated, bin}, socket) do
    {:noreply, stream_insert(socket, :bins, bin)}
  end

  defp filter_bins(search, status, container) do
    Inventory.list_bins()
    |> filter_by_search(search)
    |> filter_by_status(status)
    |> filter_by_container(container)
  end

  defp filter_by_search(bins, ""), do: bins

  defp filter_by_search(bins, search) do
    search_lower = String.downcase(search)

    Enum.filter(bins, fn bin ->
      String.contains?(String.downcase(bin.description || ""), search_lower) ||
        String.contains?(String.downcase(bin.ai_description || ""), search_lower) ||
        String.contains?("#{bin.container_id}.#{bin.bin_id}", search_lower)
    end)
  end

  defp filter_by_status(bins, "all"), do: bins
  defp filter_by_status(bins, status), do: Enum.filter(bins, &(&1.status == status))

  defp filter_by_container(bins, "all"), do: bins

  defp status_class("full"), do: "bg-green-100 text-green-800"\
  defp status_class("partial"), do: "bg-yellow-100 text-yellow-800"\
  defp status_class("empty"), do: "bg-red-100 text-red-800"\
  defp status_class(_), do: "bg-gray-100 text-gray-800"
  defp filter_by_container(bins, container) do
    container_id = String.to_integer(container)
    Enum.filter(bins, &(&1.container_id == container_id))
  end
end
