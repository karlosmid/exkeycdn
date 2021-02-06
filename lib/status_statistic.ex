defmodule ExKeyCDN.StatusStatistic do
  @moduledoc """
  Client api for https://www.ExKeyCDN.com/api#reports-api
  """
  defstruct totalcachehit: 0,
            totalcachemiss: 0,
            totalsuccess: 329,
            totalerror: 5,
            timestamp: 0
end
