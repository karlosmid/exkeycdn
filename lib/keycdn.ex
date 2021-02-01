defmodule ExKeyCDN do
  @moduledoc """
  A native ExKeyCDN REST API client in Elixir.
  Based on Braintree Elixir client:
  https://github.com/sorentwo/braintree-elixir

  For general reference please see:
  https://www.ExKeyCDN.com/api
  """

  defmodule ConfigError do
    @moduledoc """
    Raised at runtime when a config variable is missing.
    """

    defexception [:message]

    @doc """
    Build a new ConfigError exception.
    """
    @impl true
    def exception(value) do
      message = "missing config for :#{value}"

      %ConfigError{message: message}
    end
  end

  @doc """
  Convenience function for retrieving ExKeyCDN specfic environment values, but
  will raise an exception if values are missing.

  ## Example

      iex> ExKeyCDN.get_env(:random_value)
      ** (ExKeyCDN.ConfigError) missing config for :random_value

      iex> ExKeyCDN.get_env(:random_value, "random")
      "random"

      iex> Application.put_env(:exkeycdn, :random_value, "not-random")
      ...> value = ExKeyCDN.get_env(:random_value)
      ...> Application.delete_env(:exkeycdn, :random_value)
      ...> value
      "not-random"

      iex> System.put_env("RANDOM", "not-random")
      ...> Application.put_env(:exkeycdn, :system_value, {:system, "RANDOM"})
      ...> value = ExKeyCDN.get_env(:system_value)
      ...> System.delete_env("RANDOM")
      ...> value
      "not-random"
  """
  @spec get_env(atom, any) :: any
  def get_env(key, default \\ nil) do
    case Application.fetch_env(:exkeycdn, key) do
      {:ok, {:system, var}} when is_binary(var) ->
        fallback_or_raise(var, System.get_env(var), default)

      {:ok, value} ->
        value

      :error ->
        fallback_or_raise(key, nil, default)
    end
  end

  @doc """
  Convenience function for setting `ExKeyCDN` application environment
  variables.

  ## Example

      iex> ExKeyCDN.put_env(:thingy, "thing")
      ...> ExKeyCDN.get_env(:thingy)
      "thing"
  """
  @spec put_env(atom, any) :: :ok
  def put_env(key, value) do
    Application.put_env(:exkeycdn, key, value)
  end

  defp fallback_or_raise(key, nil, nil), do: raise(ConfigError, key)
  defp fallback_or_raise(_, nil, default), do: default
  defp fallback_or_raise(_, value, _), do: value
end
