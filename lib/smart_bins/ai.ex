defmodule SmartBins.AI do
  @moduledoc """
  Mock AI module for generating realistic bin content descriptions for demo purposes
  """

  @doc """
  Analyzes bin image and returns a mock AI description
  """
  def analyze_bin_image(_image_data) do
    # Simulate processing time
    Process.sleep(Enum.random(500..1500))

    # Generate a realistic AI description
    description = generate_random_description()

    {:ok, description}
  end

  defp generate_random_description do
    categories = [
      "electronics",
      "hardware",
      "tools",
      "fasteners",
      "components",
      "materials",
      "supplies"
    ]

    electronics_items = [
      "Arduino Uno microcontrollers",
      "ESP32 development boards",
      "Raspberry Pi Zero boards",
      "LED strips (WS2812B)",
      "Resistors (220Ω, 1kΩ, 10kΩ)",
      "Capacitors (ceramic, electrolytic)",
      "Breadboards (half-size)",
      "Jumper wires (male-to-male)",
      "Push buttons (tactile switches)",
      "Potentiometers (10kΩ linear)",
      "Servo motors (SG90)",
      "Stepper motors (NEMA 17)",
      "Temperature sensors (DS18B20)",
      "Ultrasonic sensors (HC-SR04)",
      "OLED displays (0.96 inch)",
      "Power supplies (5V, 12V)",
      "Soldering flux and tips"
    ]

    hardware_items = [
      "M3 x 8mm socket head screws",
      "M4 x 12mm hex bolts",
      "M5 washers (stainless steel)",
      "Hex nuts (M3, M4, M6)",
      "Lock washers (spring type)",
      "Threaded inserts (brass)",
      "T-slot nuts (2020 extrusion)",
      "Ball bearings (608ZZ)",
      "Linear rods (8mm diameter)",
      "GT2 timing belts",
      "Pulleys (20T, 5mm bore)",
      "Aluminum angle brackets",
      "Corner brackets (90 degree)",
      "Machine screws (Phillips head)",
      "Threaded rods (M8 x 300mm)"
    ]

    tools_items = [
      "Precision screwdrivers (Phillips)",
      "Hex keys (1.5mm to 6mm set)",
      "Wire strippers (20-30 AWG)",
      "Digital calipers (150mm)",
      "Tweezers (fine point, anti-static)",
      "Soldering iron tips (chisel, conical)",
      "Desoldering braid (copper)",
      "Heat shrink tubing (assorted)",
      "Cable ties (100mm, 200mm)",
      "Electrical tape (black, red)",
      "Multimeter probes",
      "Third hand with magnifier",
      "Flux pen dispensers",
      "Solder (60/40, lead-free)",
      "Anti-static wrist straps"
    ]

    fasteners_items = [
      "Wood screws (#6, #8, #10)",
      "Drywall anchors (plastic)",
      "Toggle bolts (1/4 inch)",
      "Carriage bolts (M6 x 40mm)",
      "Wing nuts (stainless steel)",
      "Thumb screws (knurled)",
      "Set screws (socket head)",
      "Cotter pins (assorted sizes)",
      "Snap rings (external, internal)",
      "Clevis pins (quick release)",
      "Retaining clips (E-clips)",
      "Rivets (aluminum, steel)",
      "Thread locker (medium strength)",
      "Washers (flat, split, fender)"
    ]

    category = Enum.random(categories)

    items =
      case category do
        "electronics" -> electronics_items
        "hardware" -> hardware_items
        "tools" -> tools_items
        "fasteners" -> fasteners_items
        _ -> electronics_items ++ hardware_items ++ tools_items
      end

    item = Enum.random(items)
    count = Enum.random(5..50)
    condition = Enum.random(["good", "excellent", "fair", "new", "used"])

    confidence = Enum.random(85..98)

    "AI detected: #{item} (qty: ~#{count}, condition: #{condition}) - #{confidence}% confidence"
  end
end
