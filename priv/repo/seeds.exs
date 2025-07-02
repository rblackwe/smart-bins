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

# Create sample bins for 5 containers with various statuses and realistic content
bins_data = [
  # Container 1 - Electronics Lab
  %{
    container_id: 1,
    bin_id: 1,
    description: "Arduino Uno R3 boards",
    status: "full",
    ai_description:
      "AI detected: Arduino Uno microcontrollers (qty: ~12, condition: new) - 94% confidence"
  },
  %{
    container_id: 1,
    bin_id: 2,
    description: "220Ω resistors",
    status: "partial",
    ai_description: nil
  },
  %{
    container_id: 1,
    bin_id: 3,
    description: "WS2812B LED strips",
    status: "empty",
    ai_description:
      "AI detected: LED strips (WS2812B) (qty: ~0, condition: good) - 89% confidence"
  },
  %{
    container_id: 1,
    bin_id: 4,
    description: "Half-size breadboards",
    status: "full",
    ai_description: nil
  },
  %{
    container_id: 1,
    bin_id: 5,
    description: "Male-to-male jumper wires",
    status: "partial",
    ai_description:
      "AI detected: Jumper wires (male-to-male) (qty: ~25, condition: good) - 91% confidence"
  },
  %{
    container_id: 1,
    bin_id: 6,
    description: "ESP32 development boards",
    status: "full",
    ai_description: nil
  },
  %{
    container_id: 1,
    bin_id: 7,
    description: "HC-SR04 ultrasonic sensors",
    status: "partial",
    ai_description:
      "AI detected: Ultrasonic sensors (HC-SR04) (qty: ~8, condition: excellent) - 96% confidence"
  },

  # Container 2 - Hardware & Fasteners
  %{
    container_id: 2,
    bin_id: 1,
    description: "M3 x 8mm socket screws",
    status: "full",
    ai_description:
      "AI detected: M3 x 8mm socket head screws (qty: ~45, condition: new) - 92% confidence"
  },
  %{
    container_id: 2,
    bin_id: 2,
    description: "M4 hex nuts",
    status: "partial",
    ai_description: nil
  },
  %{
    container_id: 2,
    bin_id: 3,
    description: "Stainless steel washers",
    status: "full",
    ai_description: nil
  },
  %{
    container_id: 2,
    bin_id: 4,
    description: "Allen key set 1.5-6mm",
    status: "empty",
    ai_description:
      "AI detected: Hex keys (1.5mm to 6mm set) (qty: ~0, condition: good) - 87% confidence"
  },
  %{
    container_id: 2,
    bin_id: 5,
    description: "T-slot nuts 2020",
    status: "partial",
    ai_description:
      "AI detected: T-slot nuts (2020 extrusion) (qty: ~18, condition: new) - 93% confidence"
  },
  %{
    container_id: 2,
    bin_id: 6,
    description: "Ball bearings 608ZZ",
    status: "full",
    ai_description: nil
  },

  # Container 3 - Precision Tools
  %{
    container_id: 3,
    bin_id: 1,
    description: "Digital calipers 150mm",
    status: "full",
    ai_description:
      "AI detected: Digital calipers (150mm) (qty: ~3, condition: excellent) - 95% confidence"
  },
  %{
    container_id: 3,
    bin_id: 2,
    description: "Anti-static tweezers",
    status: "partial",
    ai_description: nil
  },
  %{
    container_id: 3,
    bin_id: 3,
    description: "Heat shrink tubing",
    status: "full",
    ai_description:
      "AI detected: Heat shrink tubing (assorted) (qty: ~30, condition: new) - 88% confidence"
  },
  %{
    container_id: 3,
    bin_id: 4,
    description: "Soldering iron tips",
    status: "empty",
    ai_description: nil
  },
  %{
    container_id: 3,
    bin_id: 5,
    description: "Flux pen dispensers",
    status: "partial",
    ai_description: "AI detected: Flux pen dispensers (qty: ~6, condition: fair) - 90% confidence"
  },

  # Container 4 - Motors & Motion
  %{
    container_id: 4,
    bin_id: 1,
    description: "NEMA 17 stepper motors",
    status: "full",
    ai_description: nil
  },
  %{
    container_id: 4,
    bin_id: 2,
    description: "SG90 servo motors",
    status: "partial",
    ai_description:
      "AI detected: Servo motors (SG90) (qty: ~15, condition: good) - 93% confidence"
  },
  %{
    container_id: 4,
    bin_id: 3,
    description: "GT2 timing belts",
    status: "full",
    ai_description: "AI detected: GT2 timing belts (qty: ~8, condition: new) - 91% confidence"
  },
  %{
    container_id: 4,
    bin_id: 4,
    description: "20T pulleys 5mm bore",
    status: "empty",
    ai_description: nil
  },
  %{
    container_id: 4,
    bin_id: 5,
    description: "Linear rods 8mm",
    status: "partial",
    ai_description:
      "AI detected: Linear rods (8mm diameter) (qty: ~12, condition: excellent) - 89% confidence"
  },

  # Container 5 - Power & Displays
  %{
    container_id: 5,
    bin_id: 1,
    description: "5V power supplies",
    status: "full",
    ai_description:
      "AI detected: Power supplies (5V, 12V) (qty: ~7, condition: new) - 94% confidence"
  },
  %{
    container_id: 5,
    bin_id: 2,
    description: "0.96 OLED displays",
    status: "partial",
    ai_description: nil
  },
  %{
    container_id: 5,
    bin_id: 3,
    description: "Electrolytic capacitors",
    status: "full",
    ai_description:
      "AI detected: Capacitors (ceramic, electrolytic) (qty: ~35, condition: good) - 86% confidence"
  },
  %{
    container_id: 5,
    bin_id: 4,
    description: "DS18B20 temp sensors",
    status: "empty",
    ai_description: nil
  },
  %{
    container_id: 5,
    bin_id: 5,
    description: "10kΩ potentiometers",
    status: "partial",
    ai_description:
      "AI detected: Potentiometers (10kΩ linear) (qty: ~11, condition: excellent) - 92% confidence"
  }
]

# Insert bins with some having last_scanned_at timestamps
for bin_data <- bins_data do
  # Randomly assign some bins a last_scanned_at timestamp
  last_scanned_at =
    if bin_data.ai_description && Enum.random(1..3) == 1 do
      NaiveDateTime.utc_now()
      |> NaiveDateTime.add(-Enum.random(1..72), :hour)
      |> NaiveDateTime.truncate(:second)
    else
      nil
    end

  Repo.insert!(%Bin{
    container_id: bin_data.container_id,
    bin_id: bin_data.bin_id,
    description: bin_data.description,
    ai_description: bin_data.ai_description,
    status: bin_data.status,
    last_scanned_at: last_scanned_at,
    inserted_at: NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second),
    updated_at: NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second)
  })
end

IO.puts("Seeded #{length(bins_data)} bins across 5 containers")

IO.puts(
  "Created realistic demo data with electronics, hardware, tools, motors, and power components"
)
