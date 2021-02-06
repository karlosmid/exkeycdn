defmodule ExKeyCDN.ReportBehaviour do
  @moduledoc """
  Report Behaviour
  """

  @doc """
  Traffic Stats
  """
  @callback traffic(ExKeyCDN.Report) ::
              [
                {:limits, [{:rate_limit_remaining, binary()}, {:rate_limit, binary}]},
                {:stats, list(ExKeyCDN.Statistic)}
              ]
              | {:error, binary | ExKeyCDN.ErrorResponse.t()}

  @doc """
  Storage Stats
  """
  @callback storage(ExKeyCDN.Report) ::
              [
                {:limits, [{:rate_limit_remaining, binary()}, {:rate_limit, binary}]},
                {:stats, list(ExKeyCDN.Statistic)}
              ]
              | {:error, binary | ExKeyCDN.ErrorResponse.t()}
  @doc """
  Image Processing Stats
  """
  @callback image_processing(ExKeyCDN.Report) ::
              [
                {:limits, [{:rate_limit_remaining, binary()}, {:rate_limit, binary}]},
                {:stats, list(ExKeyCDN.Statistic)}
              ]
              | {:error, binary | ExKeyCDN.ErrorResponse.t()}
  @doc """
  Status Stats
  """
  @callback status(ExKeyCDN.Report) ::
              [
                {:limits, [{:rate_limit_remaining, binary()}, {:rate_limit, binary}]},
                {:stats, list(ExKeyCDN.StatusStatistic)}
              ]
              | {:error, binary | ExKeyCDN.ErrorResponse.t()}
  @doc """
  Credit Stats
  """
  @callback credit(ExKeyCDN.Report) ::
              [
                {:limits, [{:rate_limit_remaining, binary()}, {:rate_limit, binary}]},
                {:stats, list(ExKeyCDN.CreditStatstic)}
              ]
              | {:error, binary | ExKeyCDN.ErrorResponse.t()}
  @doc """
  Balance Stats
  """
  @callback balance(ExKeyCDN.Report) ::
              [
                {:limits, [{:rate_limit_remaining, binary()}, {:rate_limit, binary}]},
                {:amount, integer()}
              ]
              | {:error, binary | ExKeyCDN.ErrorResponse.t()}
end
