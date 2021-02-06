defmodule ExKeyCDN.Util do
  @moduledoc """
  General purpose utility functions.
  """

  @doc """
  Converts hyphenated values to underscore delimited strings.

  ## Examples

      iex> ExKeyCDN.Util.underscorize("key-cdn")
      "key_cdn"

      iex> ExKeyCDN.Util.underscorize(:"key-cdn")
      "key_cdn"
  """
  @spec underscorize(String.t() | atom) :: String.t()
  def underscorize(value) when is_atom(value), do: underscorize(Atom.to_string(value))

  def underscorize(value) when is_binary(value), do: String.replace(value, "-", "_")

  @doc """
  Converts underscored values to hyphenated strings.

  ## Examples

      iex> ExKeyCDN.Util.hyphenate("key_cdn")
      "key-cdn"

      iex> ExKeyCDN.Util.hyphenate(:key_cdn)
      "key-cdn"
  """
  @spec hyphenate(String.t() | atom) :: String.t()
  def hyphenate(value) when is_atom(value), do: value |> to_string() |> hyphenate()

  def hyphenate(value) when is_binary(value), do: String.replace(value, "_", "-")

  @doc """
  Recursively convert a map of string keys into a map with atom keys. Intended
  to prepare responses for conversion into structs. Note that it converts any
  string into an atom, whether it existed or not.

  For unknown maps with unknown keys this is potentially dangerous, but should
  be fine when used with known ExKeyCDN endpoints.

  ## Example

      iex> ExKeyCDN.Util.atomize(%{"a" => 1, "b" => %{"c" => 2}})
      %{a: 1, b: %{c: 2}}
  """
  @spec atomize(map) :: map
  def atomize(map) when is_map(map) do
    Enum.into(map, %{}, fn
      {key, val} when is_map(val) -> {String.to_atom(key), atomize(val)}
      {key, val} -> {String.to_atom(key), val}
    end)
  end

  @spec successfull?(map) ::
          {false, binary()} | {true, map}
  def successfull?(%{"status" => status, "description" => description} = result) do
    if status == "success" do
      {true, result}
    else
      {false, description}
    end
  end

  def successfull?(_result),
    do: {false, "API changed, :ok resopnse body does not contain status and description keys."}

  @spec map_to_struct(
          list,
          ExKeyCDN.Zone | ExKeyCDN.ZoneAlias | ExKeyCDN.ZoneReferrer | ExKeyCDN.Statistic,
          binary
        ) ::
          list | map
  def map_to_struct([], _type, _key), do: []

  def map_to_struct(items, type, key) do
    values = data(items, key)

    cond do
      is_nil(values) -> {:error, "API changed or data key value did not sent."}
      is_map(values) -> struct(type, map_to_keywordlist(values))
      true -> Enum.map(values, fn item -> struct(type, map_to_keywordlist(item)) end)
    end
  end

  defp data(items, key), do: items[key]

  @spec map_to_keywordlist(map) :: list(keyword)
  def map_to_keywordlist(map) when is_map(map),
    do: Enum.map(map, fn {key, value} -> {String.to_atom(key), value} end)

  def map_to_keywordlist(_map) do
    raise ArgumentError, message: "not a map in response list"
  end

  @spec get_limits(list(keyword)) :: [{:rate_limit, binary}, {:rate_limit_remaining, binary}]
  def get_limits(headers) do
    rate_limit = List.keyfind(headers, "X-Rate-Limit-Limit", 0)
    rate_limit = if rate_limit, do: elem(rate_limit, 1), else: :not_sent
    rate_limit_remaining = List.keyfind(headers, "X-Rate-Limit-Remaining", 0)

    rate_limit_remaining =
      if rate_limit_remaining, do: elem(rate_limit_remaining, 1), else: :not_sent

    Keyword.put([], :rate_limit, rate_limit)
    |> Keyword.put(:rate_limit_remaining, rate_limit_remaining)
  end

  @spec http :: ExKeyCDN.HTTP
  def http do
    Application.get_env(:exkeycdn, :http)
  end
end
