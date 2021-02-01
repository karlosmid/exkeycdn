defmodule ExKeyCDN.ZoneBehaviour do
  @moduledoc """
  Zone Behaviour
  """
  @doc """
  Returns a list of Zones
  """
  @callback list() :: term

  @doc """
  Returns zone based on zone id
  """
  @callback view(arg: any) :: term
end