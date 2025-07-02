defmodule SmartBins.AI do
  @moduledoc """
  OpenAI Vision API integration for bin content identification.
  """

  @openai_api_key Application.compile_env(
                    :smart_bins,
                    :openai_api_key,
                    System.get_env("OPENAI_API_KEY")
                  )
  @openai_url "https://api.openai.com/v1/chat/completions"

  @doc """
  Analyzes an image using OpenAI Vision API to identify bin contents.

  ## Examples

      iex> analyze_bin_image(image_data)
      {:ok, "M4 socket head cap screws, various lengths, stainless steel"}

  """
  def analyze_bin_image(image_data) when is_binary(image_data) do
    base64_image = Base.encode64(image_data)

    payload = %{
      model: "gpt-4-vision-preview",
      messages: [
        %{
          role: "user",
          content: [
            %{
              type: "text",
              text:
                "You are analyzing the contents of a parts bin in a warehouse. Describe what you see in this bin in a concise, practical way. Focus on: 1) Type of items 2) Material/specifications if visible 3) Approximate quantity. Keep it under 100 characters for inventory purposes."
            },
            %{
              type: "image_url",
              image_url: %{
                url: "data:image/jpeg;base64,#{base64_image}"
              }
            }
          ]
        }
      ],
      max_tokens: 150
    }

    headers = [
      {"Authorization", "Bearer #{@openai_api_key}"},
      {"Content-Type", "application/json"}
    ]

    case Req.post(@openai_url, json: payload, headers: headers) do
      {:ok, %{status: 200, body: %{"choices" => [%{"message" => %{"content" => content}} | _]}}} ->
        {:ok, String.trim(content)}

      {:ok, %{status: status, body: body}} ->
        {:error, "OpenAI API error: #{status} - #{inspect(body)}"}

      {:error, reason} ->
        {:error, "Request failed: #{inspect(reason)}"}
    end
  end

  @doc """
  Suggests tags based on AI analysis of bin contents.

  ## Examples

      iex> suggest_tags("M4 socket head cap screws, stainless steel")
      ["Hardware", "M4", "Screws", "Steel"]

  """
  def suggest_tags(ai_description) do
    # Simple keyword extraction for now
    # Could be enhanced with more sophisticated AI analysis
    keywords = [
      {"screw", "Screws"},
      {"bolt", "Bolts"},
      {"nut", "Nuts"},
      {"washer", "Washers"},
      {"arduino", "Arduino"},
      {"resistor", "Resistors"},
      {"capacitor", "Capacitors"},
      {"led", "LEDs"},
      {"wire", "Wire"},
      {"cable", "Cables"},
      {"connector", "Connectors"},
      {"m3", "M3"},
      {"m4", "M4"},
      {"m5", "M5"},
      {"steel", "Steel"},
      {"plastic", "Plastic"},
      {"aluminum", "Aluminum"},
      {"brass", "Brass"},
      {"electronic", "Electronics"},
      {"hardware", "Hardware"},
      {"fastener", "Fasteners"}
    ]

    description_lower = String.downcase(ai_description)

    keywords
    |> Enum.filter(fn {keyword, _tag} -> String.contains?(description_lower, keyword) end)
    |> Enum.map(fn {_keyword, tag} -> tag end)
    |> Enum.uniq()
    # Limit to 5 tags
    |> Enum.take(5)
  end
end
