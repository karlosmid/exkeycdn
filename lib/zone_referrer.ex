defmodule ExKeyCDN.ZoneReferrer do
  @moduledoc """
  Client api for https://www.ExKeyCDN.com/api#zones-referrers-api
  """
  defstruct id: nil,
            zone_id: 1,
            name: "hostname max 128"

  @behaviour ExKeyCDN.ZoneReferrerBehaviour
  @path "zonereferrers"
  alias ExKeyCDN.Util

  @spec list ::
          [
            {:limits, [{:rate_limit_remaining, binary()}, {:rate_limit, binary}]},
            {:zone_referrers, list(ExKeyCDN.ZoneReferrer)}
          ]
          | {:error, binary | ExKeyCDN.ErrorResponse.t()}
  @doc """
  List Zone Referrers
  """
  @impl ExKeyCDN.ZoneReferrerBehaviour
  def list do
    with {:ok, result, headers} <- Util.http().request(:get, "#{@path}.json", %{}),
         {true, result} <- Util.successfull?(result),
         zone_referrers <- Util.map_to_struct(result["data"], ExKeyCDN.ZoneReferrer, @path),
         limits <- Util.get_limits(headers) do
      [zone_referrers: zone_referrers, limits: limits]
    else
      {:error, message} -> {:error, message}
      {false, message} -> {:error, message}
    end
  end

  @spec add(ExKeyCDN.ZoneReferrer) ::
          [
            {:limits, [{:rate_limit_remaining, binary()}, {:rate_limit, binary}]},
            {:zone_referrer, ExKeyCDN.ZoneReferrer}
          ]
          | {:error, binary | ExKeyCDN.ErrorResponse.t()}

  @doc """
  Add
  """
  @impl ExKeyCDN.ZoneReferrerBehaviour
  def add(zone_referrer) do
    with {:ok, result, headers} <-
           Util.http().request(:post, "#{@path}.json", Map.from_struct(zone_referrer)),
         {true, result} <- Util.successfull?(result),
         zone_referrer <-
           Util.map_to_struct(result["data"], ExKeyCDN.ZoneReferrer, String.slice(@path, 0..-2)),
         limits <- Util.get_limits(headers) do
      [zone_referrer: zone_referrer, limits: limits]
    else
      {:error, message} -> {:error, message}
      {false, message} -> {:error, message}
    end
  end

  @spec edit(integer(), map()) ::
          [
            {:limits, [{:rate_limit_remaining, binary()}, {:rate_limit, binary}]},
            {:zone_referrer, ExKeyCDN.ZoneReferrer}
          ]
          | {:error, binary | ExKeyCDN.ErrorResponse.t()}
  @doc """
  Edit
  """
  @impl ExKeyCDN.ZoneReferrerBehaviour
  def edit(id, params) do
    with {:ok, result, headers} <- Util.http().request(:put, "#{@path}/#{id}.json", params),
         {true, result} <- Util.successfull?(result),
         zone_referrer <-
           Util.map_to_struct(result["data"], ExKeyCDN.ZoneReferrer, String.slice(@path, 0..-2)),
         limits <- Util.get_limits(headers) do
      [zone_referrer: zone_referrer, limits: limits]
    else
      {:error, message} -> {:error, message}
      {false, message} -> {:error, message}
    end
  end

  @spec delete(integer()) ::
          [
            {:limits, [{:rate_limit_remaining, binary()}, {:rate_limit, binary}]},
            {:zone_referrer, :deleted}
          ]
          | {:error, binary | ExKeyCDN.ErrorResponse.t()}
  @doc """
  Delete
  """
  @impl ExKeyCDN.ZoneReferrerBehaviour
  def delete(id) do
    with {:ok, result, headers} <- Util.http().request(:delete, "#{@path}/#{id}.json", %{}),
         {true, _result} <- Util.successfull?(result),
         limits <- Util.get_limits(headers) do
      [zone_referrer: :deleted, limits: limits]
    else
      {:error, message} -> {:error, message}
      {false, message} -> {:error, message}
    end
  end
end
