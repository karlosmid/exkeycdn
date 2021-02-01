defmodule ExKeyCDN.ErrorResponse do
  @moduledoc """
  A general purpose response wrapper that is built for any failed API
  response.

  See the following pages for details about the various responses:

  * https://www.ExKeyCDN.com/api#errors
  """

  use ExKeyCDN.Construction

  @type t :: %__MODULE__{
          errors: map,
          message: String.t(),
          params: map,
          transaction: map
        }

  defstruct errors: %{},
            message: "",
            params: %{},
            transaction: %{}
end
