defmodule KeyCDN.Zone do
  @moduledoc """
  Client api for https://www.keycdn.com/api#zones-api
  """
  defstruct name: "20 alfpanumeric charachters",
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
            cachexpullkey: "KeyCDN",
            cachecanonical: "disabled",
            cacherobots: "disabled",
            cacheerrorpages: "disabled",
            dirlistt: "disabled"

  @behaviour KeyCDN.ZoneBehaviour
  alias KeyCDN.HTTP

  @spec list_zones :: {:error, binary | KeyCDN.ErrorResponse.t()} | {list(KeyCDN.Zone), map}
  @doc """
  List Zones
  """
  @impl KeyCDN.ZoneBehaviour
  def list_zones do
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

  defp successfull?(result) do
    if result["status"] == "success" do
      {true, result}
    else
      {false, result}
    end
  end

  defp map_to_struct(zones) do
    Enum.map(zones, fn zone -> struct(KeyCDN.Zone, zone) end)
  end

  defp get_limits(headers) do
    rate_limit = List.keyfind(headers, "X-Rate-Limit-Limit", 0)
    rate_limit = if rate_limit, do: elem(rate_limit, 1)
    rate_limit_remaining = List.keyfind(headers, "X-Rate-Limit-Remaining", 0)
    rate_limit_remaining = if rate_limit_remaining, do: elem(rate_limit_remaining, 1)

    Keyword.put([], :rate_limit, rate_limit)
    |> Keyword.put(:rate_limit_remaining, rate_limit_remaining)
  end
end
