defmodule ExKeyCDN.ZoneAliasBehaviour do
  @moduledoc """
  Zone Aliases Behaviour
  """

  @doc """
  List
  """
  @callback list() ::
              [
                {:limits, [{:rate_limit_remaining, binary()}, {:rate_limit, binary}]},
                {:zone_aliases, list(ExKeyCDN.ZoneAlias)}
              ]
              | {:error, binary | ExKeyCDN.ErrorResponse.t()}

  @doc """
  Add
  """
  @callback add(ExKeyCDN.ZoneAlias) ::
              [
                {:limits, [{:rate_limit_remaining, binary()}, {:rate_limit, binary}]},
                {:zone_alias, ExKeyCDN.ZoneAlias}
              ]
              | {:error, binary | ExKeyCDN.ErrorResponse.t()}

  @doc """
  Edit
  """
  @callback edit(integer, map) ::
              [
                {:limits, [{:rate_limit_remaining, binary()}, {:rate_limit, binary}]},
                {:zone_alias, ExKeyCDN.ZoneAlias}
              ]
              | {:error, binary | ExKeyCDN.ErrorResponse.t()}

  @doc """
  Delete
  """
  @callback delete(integer()) ::
              [
                {:limits, [{:rate_limit_remaining, binary()}, {:rate_limit, binary}]},
                {:zone_alias, :deleted}
              ]
              | {:error, binary | ExKeyCDN.ErrorResponse.t()}
end
