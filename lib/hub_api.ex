defmodule HUBApi do
  @key "demo"
  @endpoint "https://api.hubapi.com/contacts/v1/lists/all/contacts/all"
  @params %{hapikey: @key, count: 100}

  def get_contacts() do
    Stream.resource(
      fn -> {false, 0} end,
      fn {has_more, offset} ->
        params = if has_more, do: Map.put(@params, :vidOffset, offset), else: @params

        json_body =
          case Peppermint.get(@endpoint, params: params) do
            {:ok, %{status: 200, body: body}} ->
              Jason.decode!(body)

            {:error, _} ->
              {:halt, []}
          end

        {json_body["contacts"], {json_body["has-more"], json_body["vid-offset"]}}
      end,
      fn _ -> [] end
    )
  end

  def get_emails(count \\ 100) do
    get_contacts()
    |> Stream.take(count)
    |> identity_profiles()
    |> identities()
    |> emails()
    |> Enum.to_list()
  end

  defp identity_profiles(contacts), do: contacts |> Stream.flat_map(& &1["identity-profiles"])
  defp identities(identities), do: identities |> Stream.flat_map(& &1["identities"])

  defp emails(list),
    do: list |> Stream.filter(&(&1["type"] == "EMAIL")) |> Stream.map(& &1["value"])
end
