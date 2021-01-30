defmodule KeyCDN.Decoder do
  @moduledoc """
  Decoded JSON string
  """
  @spec decode(binary) :: nil
  def decode(json_value) do
    Jason.decode!(json_value)
  end
end
