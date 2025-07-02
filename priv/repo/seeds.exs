# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     SmartBins.Repo.insert!(%SmartBins.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias SmartBins.Repo
alias SmartBins.Inventory.Bin
import Ecto.Query

# Clear existing data
Repo.delete_all(Bin)

# Create sample bins for 3 containers with various statuses
bins_data = [
  # Container 1 - Electronics
  %{container_id: 1, bin_id: 1, description: "Arduino Uno boards", status: "full"},
  %{container_id: 1, bin_id: 2, description: "Resistors 220Ω", status: "partial"},
  %{container_id: 1, bin_id: 3, description: "LED strips", status: "empty"},
  %{container_id: 1, bin_id: 4, description: "Breadboards", status: "full"},
  %{container_id: 1, bin_id: 5, description: "Jumper wires", status: "partial"},

  # Container 2 - Hardware
  %{container_id: 2, bin_id: 1, description: "M3 screws", status: "full"},
  %{container_id: 2, bin_id: 2, description: "M4 nuts", status: "partial"},
  %{container_id: 2, bin_id: 3, description: "Washers assorted", status: "full"},
  %{container_id: 2, bin_id: 4, description: "Allen keys", status: "empty"},

  # Container 3 - Tools
  %{container_id: 3, bin_id: 1, description: "Wire strippers", status: "full"},
  %{container_id: 3, bin_id: 2, description: "Soldering tips", status: "partial"},
  %{container_id: 3, bin_id: 3, description: "Heat shrink tubing", status: "full"}
]

# Insert bins
for bin_data <- bins_data do
  Repo.insert!(%Bin{
    container_id: bin_data.container_id,
    bin_id: bin_data.bin_id,
    description: bin_data.description,
    status: bin_data.status,
    inserted_at: NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second),
    updated_at: NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second)
  })
end

IO.puts("Seeded #{length(bins_data)} bins across 3 containers")
