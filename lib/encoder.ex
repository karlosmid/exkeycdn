defmodule ExKeyCDN.Encoder do
  @moduledoc """
  Encodes map to application/x-www-form-urlencoded
  """
  @spec encode(map) :: binary | {:error, binary}
  def encode(body) when is_map(body) do
    body
    |> Enum.map(fn {key, value} ->
      case is_atom(key) do
        true -> "#{:hackney_url.urlencode(Atom.to_string(key))}=#{:hackney_url.urlencode(value)}"
        false -> "#{:hackney_url.urlencode(key)}=#{:hackney_url.urlencode(value)}"
      end
    end)
    |> Enum.join("&")
  end

  def encode(_body), do: {:error, "Request body must be a map."}
end
