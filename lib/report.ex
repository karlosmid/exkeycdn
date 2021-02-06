defmodule ExKeyCDN.Report do
  @moduledoc """
  Client api for https://www.ExKeyCDN.com/api#reports-api
  """
  defstruct zone_id: 1,
            start: 0,
            end: 0

  @behaviour ExKeyCDN.ReportBehaviour
  @path "reports"
  alias ExKeyCDN.{Statistic, Util}

  @spec traffic(ExKeyCDN.Report) ::
          [
            {:limits, [{:rate_limit_remaining, binary()}, {:rate_limit, binary}]},
            {:stats, list(ExKeyCDN.Statistic)}
          ]
          | {:error, binary | ExKeyCDN.ErrorResponse.t()}
  @doc """
  Traffic Stats
  """
  @impl ExKeyCDN.ReportBehaviour
  def traffic(params) do
    with {:ok, result, headers} <-
           Util.http().request(:get, "#{@path}/traffic.json", Map.from_struct(params)),
         {true, result} <- Util.successfull?(result),
         stats <- Util.map_to_struct(result["data"], Statistic, "stats"),
         limits <- Util.get_limits(headers) do
      [stats: stats, limits: limits]
    else
      {:error, message} -> {:error, message}
      {false, message} -> {:error, message}
    end
  end
end
