defmodule KeyCDN.ZoneBehaviour do
  @moduledoc """
  Zone Behaviour
  """
  @doc """
  Returns a list of Zones
  """
  @callback list() :: term
end
