defmodule ExKeyCDN.ZoneAlias do
  @moduledoc """
  Client api for https://www.ExKeyCDN.com/api#zones-aliases-api
  """
  defstruct id: nil,
            zone_id: 1,
            name: "hostname max 128"

  @behaviour ExKeyCDN.ZoneAliasBehaviour
  @path "zonealiases"
  alias ExKeyCDN.Util

  @spec list ::
          [
            {:limits, [{:rate_limit_remaining, binary()}, {:rate_limit, binary}]},
            {:zone_aliases, list(ExKeyCDN.ZoneAlias)}
          ]
          | {:error, binary | ExKeyCDN.ErrorResponse.t()}
  @doc """
  List Zone Aliases
  """
  @impl ExKeyCDN.ZoneAliasBehaviour
  def list do
    with {:ok, result, headers} <- Util.http().request(:get, "#{@path}.json", %{}),
         {true, result} <- Util.successfull?(result),
         zone_aliases <- Util.map_to_struct(result["data"], ExKeyCDN.ZoneAlias, @path),
         limits <- Util.get_limits(headers) do
      [zone_aliases: zone_aliases, limits: limits]
    else
      {:error, message} -> {:error, message}
      {false, message} -> {:error, message}
    end
  end

  @spec add(ExKeyCDN.ZoneAlias) ::
          [
            {:limits, [{:rate_limit_remaining, binary()}, {:rate_limit, binary}]},
            {:zone_alias, ExKeyCDN.ZoneAlias}
          ]
          | {:error, binary | ExKeyCDN.ErrorResponse.t()}

  @doc """
  Add
  """
  @impl ExKeyCDN.ZoneAliasBehaviour
  def add(zone_alias) do
    with {:ok, result, headers} <-
           Util.http().request(:post, "#{@path}.json", Map.from_struct(zone_alias)),
         {true, result} <- Util.successfull?(result),
         zone_alias <-
           Util.map_to_struct(result["data"], ExKeyCDN.ZoneAlias, String.slice(@path, 0..-3)),
         limits <- Util.get_limits(headers) do
      [zone_alias: zone_alias, limits: limits]
    else
      {:error, message} -> {:error, message}
      {false, message} -> {:error, message}
    end
  end

  @spec edit(integer(), map()) ::
          [
            {:limits, [{:rate_limit_remaining, binary()}, {:rate_limit, binary}]},
            {:zone_alias, ExKeyCDN.ZoneAlias}
          ]
          | {:error, binary | ExKeyCDN.ErrorResponse.t()}
  @doc """
  Edit
  """
  @impl ExKeyCDN.ZoneAliasBehaviour
  def edit(id, params) do
    with {:ok, result, headers} <- Util.http().request(:put, "#{@path}/#{id}.json", params),
         {true, result} <- Util.successfull?(result),
         zone_alias <-
           Util.map_to_struct(result["data"], ExKeyCDN.ZoneAlias, String.slice(@path, 0..-3)),
         limits <- Util.get_limits(headers) do
      [zone_alias: zone_alias, limits: limits]
    else
      {:error, message} -> {:error, message}
      {false, message} -> {:error, message}
    end
  end

  @spec delete(integer()) ::
          [
            {:limits, [{:rate_limit_remaining, binary()}, {:rate_limit, binary}]},
            {:zone_alias, :deleted}
          ]
          | {:error, binary | ExKeyCDN.ErrorResponse.t()}
  @doc """
  Delete
  """
  @impl ExKeyCDN.ZoneAliasBehaviour
  def delete(id) do
    with {:ok, result, headers} <- Util.http().request(:delete, "#{@path}/#{id}.json", %{}),
         {true, _result} <- Util.successfull?(result),
         limits <- Util.get_limits(headers) do
      [zone_alias: :deleted, limits: limits]
    else
      {:error, message} -> {:error, message}
      {false, message} -> {:error, message}
    end
  end
end
