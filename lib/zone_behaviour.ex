defmodule ExKeyCDN.ZoneBehaviour do
  @moduledoc """
  Zone Behaviour
  """
  @callback list() ::
              [
                {:limits, [{:rate_limit_remaining, binary()}, {:rate_limit, binary}]},
                {:zones, list(ExKeyCDN.Zone)}
              ]
              | {:error, binary | ExKeyCDN.ErrorResponse.t()}

  @doc """
  Returns zone based on id
  """
  @callback view(integer) ::
              [
                {:limits, [{:rate_limit_remaining, binary()}, {:rate_limit, binary}]},
                {:zone, ExKeyCDN.Zone}
              ]
              | {:error, binary | ExKeyCDN.ErrorResponse.t()}

  @doc """
  Add
  """
  @callback add(ExKeyCDN.Zone.t()) ::
              [
                {:limits, [{:rate_limit_remaining, binary()}, {:rate_limit, binary}]},
                {:zone, ExKeyCDN.Zone}
              ]
              | {:error, binary | ExKeyCDN.ErrorResponse.t()}

  @doc """
  Edit
  """
  @callback edit(integer, map) ::
              [
                {:limits, [{:rate_limit_remaining, binary()}, {:rate_limit, binary}]},
                {:zone, ExKeyCDN.Zone}
              ]
              | {:error, binary | ExKeyCDN.ErrorResponse.t()}

  @doc """
  Delete
  """
  @callback delete(integer()) ::
              [
                {:limits, [{:rate_limit_remaining, binary()}, {:rate_limit, binary}]},
                {:zone, :deleted}
              ]
              | {:error, binary | ExKeyCDN.ErrorResponse.t()}

  @doc """
  Purge Cache
  """
  @callback purge_cache(integer()) ::
              [
                {:limits, [{:rate_limit_remaining, binary()}, {:rate_limit, binary}]},
                {:zone, :cache_purged}
              ]
              | {:error, binary | ExKeyCDN.ErrorResponse.t()}

  @doc """
  Purge URL
  """
  @callback purge_url(integer(), list) ::
              [
                {:limits, [{:rate_limit_remaining, binary()}, {:rate_limit, binary}]},
                {:zone, :url_purged}
              ]
              | {:error, binary | ExKeyCDN.ErrorResponse.t()}
end
