defmodule ExKeyCDN.JsonEncoder do
  @moduledoc """
  Encodes map to application/json
  """
  @spec encode(map) :: binary | {:error, binary}
  def encode(body) when is_map(body) do
    case Jason.encode(body) do
      {:ok, json} -> json
      {:error, %Jason.EncodeError{message: message}} -> {:error, message}
      _ -> {:error, "Unable to encode to json."}
    end
  end

  def encode(_body), do: {:error, "Request body must be a map."}
end
