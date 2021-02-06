defmodule ExKeyCDN.ZoneReferrerBehaviour do
  @moduledoc """
  Zone Referrers Behaviour
  """
  @callback list() ::
              [
                {:limits, [{:rate_limit_remaining, binary()}, {:rate_limit, binary}]},
                {:zone_referrers, list(ExKeyCDN.ZoneReferrer)}
              ]
              | {:error, binary | ExKeyCDN.ErrorResponse.t()}

  @doc """
  Add
  """
  @callback add(ExKeyCDN.ZoneReferrer.t()) ::
              [
                {:limits, [{:rate_limit_remaining, binary()}, {:rate_limit, binary}]},
                {:zone_referrer, ExKeyCDN.ZoneReferrer}
              ]
              | {:error, binary | ExKeyCDN.ErrorResponse.t()}

  @doc """
  Edit
  """
  @callback edit(integer, map) ::
              [
                {:limits, [{:rate_limit_remaining, binary()}, {:rate_limit, binary}]},
                {:zone_referrer, ExKeyCDN.ZoneReferrer}
              ]
              | {:error, binary | ExKeyCDN.ErrorResponse.t()}

  @doc """
  Delete
  """
  @callback delete(integer()) ::
              [
                {:limits, [{:rate_limit_remaining, binary()}, {:rate_limit, binary}]},
                {:zone_referrer, :deleted}
              ]
              | {:error, binary | ExKeyCDN.ErrorResponse.t()}
end
