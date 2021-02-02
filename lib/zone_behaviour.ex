defmodule ExKeyCDN.ZoneBehaviour do
  @moduledoc """
  Zone Behaviour
  """
  @doc """
  Returns a list of Zones
  """
  @callback list() ::
              [
                {:limits, [{:rate_limit_remaining, binary()}, {:rate_limit, binary}]},
                {:zones, list(ExKeyCDN.Zone)}
              ]
              | {:error, binary | ExKeyCDN.ErrorResponse.t()}

  @doc """
  Returns zone based on zone id
  """
  @callback view(integer) ::
              [
                {:limits, [{:rate_limit_remaining, binary()}, {:rate_limit, binary}]},
                {:zone, ExKeyCDN.Zone}
              ]
              | {:error, binary | ExKeyCDN.ErrorResponse.t()}

  @doc """
  Add zone
  """
  @callback add(ExKeyCDN.Zone.t()) ::
              [
                {:limits, [{:rate_limit_remaining, binary()}, {:rate_limit, binary}]},
                {:zone, ExKeyCDN.Zone}
              ]
              | {:error, binary | ExKeyCDN.ErrorResponse.t()}

  @doc """
  Edit zone
  """
  @callback edit(integer, map) ::
              [
                {:limits, [{:rate_limit_remaining, binary()}, {:rate_limit, binary}]},
                {:zone, ExKeyCDN.Zone}
              ]
              | {:error, binary | ExKeyCDN.ErrorResponse.t()}
end
