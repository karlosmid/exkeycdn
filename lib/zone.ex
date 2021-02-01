defmodule ExKeyCDN.Zone do
  @moduledoc """
  Client api for https://www.ExKeyCDN.com/api#zones-api
  """
  defstruct id: nil,
            name: "20 alfpanumeric charachters",
            status: "active",
            type: "push",
            forcedownload: "disabled",
            cors: "disabled",
            gzip: "disabled",
            imgproc: "disabled",
            expire: 0,
            blockbadbots: "disabled",
            allowemptyreferrer: "enabled",
            blockreferrer: "disabled",
            securetoken: "disabled",
            securetokenkey: "4-5 alphanumeric",
            sslcert: :shared,
            customsslkey: "valid key",
            customsslcert: "valid cert",
            forcessl: "disabled",
            originurl: "url of max 128 characters",
            originshield: "disabled",
            cachemaxexpire: 1440,
            cacheignorecachecontrol: "enabled",
            cacheignorequerystring: "enabled",
            cachehostheader: "disabled",
            cachekeyscheme: "disabled",
            cachekeyhost: "disabled",
            cachekeycookie: "alphanumeric 32 charachters",
            cachekeydevice: "disabled",
            cachekeywebp: "disabled",
            cachebr: "disabled",
            cachecookies: "disabled",
            cachestripcookies: "disabled",
            cachexpullkey: "ExKeyCDN",
            cachecanonical: "disabled",
            cacherobots: "disabled",
            cacheerrorpages: "disabled",
            dirlistt: "disabled"

  @behaviour ExKeyCDN.ZoneBehaviour
  alias ExKeyCDN.HTTP

  @spec list :: {:error, binary | ExKeyCDN.ErrorResponse.t()} | {list(ExKeyCDN.Zone), map}
  @doc """
  List Zones
  """
  @impl ExKeyCDN.ZoneBehaviour
  def list do
    with {:ok, result, headers} <- HTTP.request(:get, "zones.json"),
         {true, result} <- successfull?(result),
         zones <- map_to_struct(result["data"]["zones"]),
         limits <- get_limits(headers) do
      [zones: zones, limits: limits]
    else
      {:error, message} -> {:error, message}
      {false, result} -> result
    end
  end

  @doc """
  View Zone
  """
  @impl ExKeyCDN.ZoneBehaviour
  def view(id) do
    with {:ok, result, headers} <- HTTP.request(:get, "zones/#{id}.json"),
         {true, result} <- successfull?(result),
         zones <- map_to_struct(result["data"]["zone"]),
         limits <- get_limits(headers) do
      [zones: zones, limits: limits]
    else
      {:error, message} -> {:error, message}
      {false, result} -> result
    end
  end
  defp successfull?(result) do
    if result["status"] == "success" do
      {true, result}
    else
      {false, result}
    end
  end

  defp map_to_struct(zones) when is_list(zones) do
    Enum.map(zones, fn zone -> map_to_struct(zone) end)
  end
  defp map_to_struct(zone), do: struct(ExKeyCDN.Zone, map_to_keywordlist(zone))

  defp map_to_keywordlist(map), do: Enum.map(map, fn {key, value} -> {String.to_atom(key), value} end)

  defp get_limits(headers) do
    rate_limit = List.keyfind(headers, "X-Rate-Limit-Limit", 0)
    rate_limit = if rate_limit, do: elem(rate_limit, 1)
    rate_limit_remaining = List.keyfind(headers, "X-Rate-Limit-Remaining", 0)
    rate_limit_remaining = if rate_limit_remaining, do: elem(rate_limit_remaining, 1)

    Keyword.put([], :rate_limit, rate_limit)
    |> Keyword.put(:rate_limit_remaining, rate_limit_remaining)
  end
end