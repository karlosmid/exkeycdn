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
            securetokenkey: "",
            sslcert: :shared,
            customsslkey: "valid key",
            customsslcert: "valid cert",
            forcessl: "disabled",
            originurl: "https://example.com",
            originshield: "disabled",
            cachemaxexpire: 1440,
            cacheignorecachecontrol: "enabled",
            cacheignorequerystring: "enabled",
            cachehostheader: "disabled",
            cachekeyscheme: "disabled",
            cachekeyhost: "disabled",
            cachekeycookie: "alphanumeric32charachters",
            cachekeydevice: "disabled",
            cachekeywebp: "disabled",
            cachebr: "disabled",
            cachecookies: "disabled",
            cachestripcookies: "disabled",
            cachexpullkey: "ExKeyCDN",
            cachecanonical: "disabled",
            cacherobots: "disabled",
            cacheerrorpages: "disabled",
            dirlist: "disabled"

  @behaviour ExKeyCDN.ZoneBehaviour
  @path "zones"
  alias ExKeyCDN.Util

  @spec list ::
          [
            {:limits, [{:rate_limit_remaining, binary()}, {:rate_limit, binary}]},
            {:zones, list(ExKeyCDN.Zone)}
          ]
          | {:error, binary | ExKeyCDN.ErrorResponse.t()}
  @doc """
  List Zones
  """
  @impl ExKeyCDN.ZoneBehaviour
  def list do
    with {:ok, result, headers} <- http().request(:get, "#{@path}.json", %{}),
         {true, result} <- Util.successfull?(result),
         zones <- Util.map_to_struct(result["data"], ExKeyCDN.Zone, @path),
         limits <- Util.get_limits(headers) do
      [zones: zones, limits: limits]
    else
      {:error, message} -> {:error, message}
      {false, message} -> {:error, message}
    end
  end

  @spec view(integer()) ::
          [
            {:limits, [{:rate_limit_remaining, binary()}, {:rate_limit, binary}]},
            {:zone, ExKeyCDN.Zone}
          ]
          | {:error, binary | ExKeyCDN.ErrorResponse.t()}
  @doc """
  View
  """
  @impl ExKeyCDN.ZoneBehaviour
  def view(id) do
    with {:ok, result, headers} <- http().request(:get, "#{@path}/#{id}.json", %{}),
         {true, result} <- Util.successfull?(result),
         zone <- Util.map_to_struct(result["data"], ExKeyCDN.Zone, String.slice(@path, 0..-2)),
         limits <- Util.get_limits(headers) do
      [zone: zone, limits: limits]
    else
      {:error, message} -> {:error, message}
      {false, message} -> {:error, message}
    end
  end

  @spec add(ExKeyCDN.Zone) ::
          [
            {:limits, [{:rate_limit_remaining, binary()}, {:rate_limit, binary}]},
            {:zone, ExKeyCDN.Zone}
          ]
          | {:error, binary | ExKeyCDN.ErrorResponse.t()}
  @doc """
  Add
  """
  @impl ExKeyCDN.ZoneBehaviour
  def add(zone) do
    with {:ok, result, headers} <- http().request(:post, "#{@path}.json", Map.from_struct(zone)),
         {true, result} <- Util.successfull?(result),
         zone <- Util.map_to_struct(result["data"], ExKeyCDN.Zone, String.slice(@path, 0..-2)),
         limits <- Util.get_limits(headers) do
      [zone: zone, limits: limits]
    else
      {:error, message} -> {:error, message}
      {false, message} -> {:error, message}
    end
  end

  @spec edit(integer(), map()) ::
          [
            {:limits, [{:rate_limit_remaining, binary()}, {:rate_limit, binary}]},
            {:zone, ExKeyCDN.Zone}
          ]
          | {:error, binary | ExKeyCDN.ErrorResponse.t()}
  @doc """
  Edit
  """
  @impl ExKeyCDN.ZoneBehaviour
  def edit(id, params) do
    with {:ok, result, headers} <- http().request(:put, "#{@path}/#{id}.json", params),
         {true, result} <- Util.successfull?(result),
         zone <- Util.map_to_struct(result["data"], ExKeyCDN.Zone, String.slice(@path, 0..-2)),
         limits <- Util.get_limits(headers) do
      [zone: zone, limits: limits]
    else
      {:error, message} -> {:error, message}
      {false, message} -> {:error, message}
    end
  end

  @spec delete(integer()) ::
          [
            {:limits, [{:rate_limit_remaining, binary()}, {:rate_limit, binary}]},
            {:zone, :deleted}
          ]
          | {:error, binary | ExKeyCDN.ErrorResponse.t()}
  @doc """
  Delete
  """
  @impl ExKeyCDN.ZoneBehaviour
  def delete(id) do
    with {:ok, result, headers} <- http().request(:delete, "#{@path}/#{id}.json", %{}),
         {true, _result} <- Util.successfull?(result),
         limits <- Util.get_limits(headers) do
      [zone: :deleted, limits: limits]
    else
      {:error, message} -> {:error, message}
      {false, message} -> {:error, message}
    end
  end

  @spec purge_cache(integer()) ::
          [
            {:limits, [{:rate_limit_remaining, binary()}, {:rate_limit, binary}]},
            {:zone, :cache_purged}
          ]
          | {:error, binary | ExKeyCDN.ErrorResponse.t()}
  @doc """
  Purge Cache
  """
  @impl ExKeyCDN.ZoneBehaviour
  def purge_cache(id) do
    with {:ok, result, headers} <- http().request(:get, "#{@path}/purge/#{id}.json", %{}),
         {true, _result} <- Util.successfull?(result),
         limits <- Util.get_limits(headers) do
      [zone: :cache_purged, limits: limits]
    else
      {:error, message} -> {:error, message}
      {false, message} -> {:error, message}
    end
  end

  @spec purge_url(integer(), list) ::
          [
            {:limits, [{:rate_limit_remaining, binary()}, {:rate_limit, binary}]},
            {:zone, :url_purged}
          ]
          | {:error, binary | ExKeyCDN.ErrorResponse.t()}
  @doc """
  Purge URL
  """
  @impl ExKeyCDN.ZoneBehaviour
  def purge_url(id, urls) do
    with {:ok, result, headers} <-
           http().request(:delete, "#{@path}/purgeurl/#{id}.json", %{urls: urls}),
         {true, _result} <- Util.successfull?(result),
         limits <- Util.get_limits(headers) do
      [zone: :url_purged, limits: limits]
    else
      {:error, message} -> {:error, message}
      {false, message} -> {:error, message}
    end
  end

  defp http do
    Application.get_env(:exkeycdn, :http)
  end
end
