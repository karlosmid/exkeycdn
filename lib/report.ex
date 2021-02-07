defmodule ExKeyCDN.Report do
  @moduledoc """
  Client api for https://www.ExKeyCDN.com/api#reports-api
  """
  defstruct zone_id: 1,
            start: 0,
            end: 0

  @behaviour ExKeyCDN.ReportBehaviour
  @path "reports"
  alias ExKeyCDN.{CreditStatistic, Statistic, StatusStatistic, Util}

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

  @spec storage(ExKeyCDN.Report) ::
          [
            {:limits, [{:rate_limit_remaining, binary()}, {:rate_limit, binary}]},
            {:stats, list(ExKeyCDN.Statistic)}
          ]
          | {:error, binary | ExKeyCDN.ErrorResponse.t()}
  @doc """
  Storage Stats
  """
  @impl ExKeyCDN.ReportBehaviour
  def storage(params) do
    with {:ok, result, headers} <-
           Util.http().request(:get, "#{@path}/storage.json", Map.from_struct(params)),
         {true, result} <- Util.successfull?(result),
         stats <- Util.map_to_struct(result["data"], Statistic, "stats"),
         limits <- Util.get_limits(headers) do
      [stats: stats, limits: limits]
    else
      {:error, message} -> {:error, message}
      {false, message} -> {:error, message}
    end
  end

  @spec image_processing(ExKeyCDN.Report) ::
          [
            {:limits, [{:rate_limit_remaining, binary()}, {:rate_limit, binary}]},
            {:stats, list(ExKeyCDN.Statistic)}
          ]
          | {:error, binary | ExKeyCDN.ErrorResponse.t()}
  @doc """
  Image Processing Stats
  """
  @impl ExKeyCDN.ReportBehaviour
  def image_processing(params) do
    with {:ok, result, headers} <-
           Util.http().request(:get, "#{@path}/ip.json", Map.from_struct(params)),
         {true, result} <- Util.successfull?(result),
         stats <- Util.map_to_struct(result["data"], Statistic, "stats"),
         limits <- Util.get_limits(headers) do
      [stats: stats, limits: limits]
    else
      {:error, message} -> {:error, message}
      {false, message} -> {:error, message}
    end
  end

  @spec status(ExKeyCDN.Report) ::
          [
            {:limits, [{:rate_limit_remaining, binary()}, {:rate_limit, binary}]},
            {:stats, list(ExKeyCDN.StatusStatistic)}
          ]
          | {:error, binary | ExKeyCDN.ErrorResponse.t()}
  @doc """
  Status Stats
  """
  @impl ExKeyCDN.ReportBehaviour
  def status(params) do
    with {:ok, result, headers} <-
           Util.http().request(:get, "#{@path}/statestats.json", Map.from_struct(params)),
         {true, result} <- Util.successfull?(result),
         stats <- Util.map_to_struct(result["data"], StatusStatistic, "stats"),
         limits <- Util.get_limits(headers) do
      [stats: stats, limits: limits]
    else
      {:error, message} -> {:error, message}
      {false, message} -> {:error, message}
    end
  end

  @spec credit(ExKeyCDN.Report) ::
          [
            {:limits, [{:rate_limit_remaining, binary()}, {:rate_limit, binary}]},
            {:stats, list(ExKeyCDN.CreditStatistic)}
          ]
          | {:error, binary | ExKeyCDN.ErrorResponse.t()}
  @doc """
  Credit Stats
  """
  @impl ExKeyCDN.ReportBehaviour
  def credit(params) do
    with {:ok, result, headers} <-
           Util.http().request(:get, "#{@path}/credits.json", Map.from_struct(params)),
         {true, result} <- Util.successfull?(result),
         stats <- Util.map_to_struct(result["data"], CreditStatistic, "stats"),
         limits <- Util.get_limits(headers) do
      [stats: stats, limits: limits]
    else
      {:error, message} -> {:error, message}
      {false, message} -> {:error, message}
    end
  end

  @spec balance() ::
          [
            {:limits, [{:rate_limit_remaining, binary()}, {:rate_limit, binary}]},
            {:amount, binary()}
          ]
          | {:error, binary | ExKeyCDN.ErrorResponse.t()}
  @doc """
  Balance Stats
  """
  @impl ExKeyCDN.ReportBehaviour
  def balance do
    with {:ok, result, headers} <-
           Util.http().request(:get, "#{@path}/creditbalance.json", %{}),
         {true, result} <- Util.successfull?(result),
         amount <- result["data"]["amount"],
         limits <- Util.get_limits(headers) do
      [amount: amount, limits: limits]
    else
      {:error, message} -> {:error, message}
      {false, message} -> {:error, message}
    end
  end
end
