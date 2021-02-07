defmodule ExKeyCDN.Decoder do
  @moduledoc """
  Decoded JSON string
  """
  @spec decode(binary) :: map
  def decode(json_value) do
    Jason.decode!(json_value)
  end
end
