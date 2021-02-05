defmodule ExKeyCDN.HTTPBehaviour do
  @moduledoc """
  HTTP Behaviour
  """
  @doc """
  Sends http request
  """
  @callback request(atom, binary, binary | map) :: HTTP.response()
end
