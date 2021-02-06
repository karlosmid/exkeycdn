defmodule ExKeyCDN.ReportTest do
  use ExUnit.Case, async: true

  import Mox

  # Make sure mocks are verified when the test exits
  setup :verify_on_exit!

  describe "traffic/1" do
    test "mock" do
      expected = [
        stats: [%ExKeyCDN.Statistic{}, %ExKeyCDN.Statistic{}],
        limits: [rate_limit_remaining: "60", rate_limit: "60"]
      ]

      input = Map.from_struct(%ExKeyCDN.Report{})

      ExKeyCDN.MockReport
      |> expect(:traffic, fn _input -> expected end)

      assert report().traffic(input) == expected
    end

    test "mock http and ok" do
      expected = [
        stats: [],
        limits: [rate_limit_remaining: "60", rate_limit: "60"]
      ]

      mocked =
        {:ok, %{"data" => [], "status" => "success", "description" => "good work"},
         [{"X-Rate-Limit-Limit", "60"}, {"X-Rate-Limit-Remaining", "60"}]}

      _input = Map.from_struct(%ExKeyCDN.Report{})

      ExKeyCDN.MockHTTP
      |> expect(:request, fn :get, "reports/traffic.json", _input -> mocked end)

      assert ExKeyCDN.Report.traffic(%ExKeyCDN.Report{}) == expected
    end

    test "mock http and error" do
      expected = {:error, :forbidden}

      ExKeyCDN.MockHTTP
      |> expect(:request, fn :get, "reports/traffic.json", %{} -> expected end)

      assert ExKeyCDN.Report.traffic(%ExKeyCDN.Report{}) == expected
    end

    test "mock http and not successfull" do
      expected = {:error, "error message"}
      mocked = {:ok, %{"status" => "error", "description" => "error message"}, []}

      ExKeyCDN.MockHTTP
      |> expect(:request, fn :get, "reports/traffic.json", %{} -> mocked end)

      assert ExKeyCDN.Report.traffic(%ExKeyCDN.Report{}) == expected
    end
  end

  describe "storage/1" do
    test "mock" do
      expected = [
        stats: [%ExKeyCDN.Statistic{}, %ExKeyCDN.Statistic{}],
        limits: [rate_limit_remaining: "60", rate_limit: "60"]
      ]

      input = Map.from_struct(%ExKeyCDN.Report{})

      ExKeyCDN.MockReport
      |> expect(:storage, fn _input -> expected end)

      assert report().storage(input) == expected
    end

    test "mock http and ok" do
      expected = [
        stats: [],
        limits: [rate_limit_remaining: "60", rate_limit: "60"]
      ]

      mocked =
        {:ok, %{"data" => [], "status" => "success", "description" => "good work"},
         [{"X-Rate-Limit-Limit", "60"}, {"X-Rate-Limit-Remaining", "60"}]}

      _input = Map.from_struct(%ExKeyCDN.Report{})

      ExKeyCDN.MockHTTP
      |> expect(:request, fn :get, "reports/storage.json", _input -> mocked end)

      assert ExKeyCDN.Report.storage(%ExKeyCDN.Report{}) == expected
    end

    test "mock http and error" do
      expected = {:error, :forbidden}

      ExKeyCDN.MockHTTP
      |> expect(:request, fn :get, "reports/storage.json", %{} -> expected end)

      assert ExKeyCDN.Report.storage(%ExKeyCDN.Report{}) == expected
    end

    test "mock http and not successfull" do
      expected = {:error, "error message"}
      mocked = {:ok, %{"status" => "error", "description" => "error message"}, []}

      ExKeyCDN.MockHTTP
      |> expect(:request, fn :get, "reports/storage.json", %{} -> mocked end)

      assert ExKeyCDN.Report.storage(%ExKeyCDN.Report{}) == expected
    end
  end

  describe "image_processing/1" do
    test "mock" do
      expected = [
        stats: [%ExKeyCDN.Statistic{}, %ExKeyCDN.Statistic{}],
        limits: [rate_limit_remaining: "60", rate_limit: "60"]
      ]

      input = Map.from_struct(%ExKeyCDN.Report{})

      ExKeyCDN.MockReport
      |> expect(:image_processing, fn _input -> expected end)

      assert report().image_processing(input) == expected
    end

    test "mock http and ok" do
      expected = [
        stats: [],
        limits: [rate_limit_remaining: "60", rate_limit: "60"]
      ]

      mocked =
        {:ok, %{"data" => [], "status" => "success", "description" => "good work"},
         [{"X-Rate-Limit-Limit", "60"}, {"X-Rate-Limit-Remaining", "60"}]}

      _input = Map.from_struct(%ExKeyCDN.Report{})

      ExKeyCDN.MockHTTP
      |> expect(:request, fn :get, "reports/ip.json", _input -> mocked end)

      assert ExKeyCDN.Report.image_processing(%ExKeyCDN.Report{}) == expected
    end

    test "mock http and error" do
      expected = {:error, :forbidden}

      ExKeyCDN.MockHTTP
      |> expect(:request, fn :get, "reports/ip.json", %{} -> expected end)

      assert ExKeyCDN.Report.image_processing(%ExKeyCDN.Report{}) == expected
    end

    test "mock http and not successfull" do
      expected = {:error, "error message"}
      mocked = {:ok, %{"status" => "error", "description" => "error message"}, []}

      ExKeyCDN.MockHTTP
      |> expect(:request, fn :get, "reports/ip.json", %{} -> mocked end)

      assert ExKeyCDN.Report.image_processing(%ExKeyCDN.Report{}) == expected
    end
  end

  describe "status/1" do
    test "mock" do
      expected = [
        stats: [%ExKeyCDN.StatusStatistic{}, %ExKeyCDN.StatusStatistic{}],
        limits: [rate_limit_remaining: "60", rate_limit: "60"]
      ]

      input = Map.from_struct(%ExKeyCDN.Report{})

      ExKeyCDN.MockReport
      |> expect(:status, fn _input -> expected end)

      assert report().status(input) == expected
    end

    test "mock http and ok" do
      expected = [
        stats: [],
        limits: [rate_limit_remaining: "60", rate_limit: "60"]
      ]

      mocked =
        {:ok, %{"data" => [], "status" => "success", "description" => "good work"},
         [{"X-Rate-Limit-Limit", "60"}, {"X-Rate-Limit-Remaining", "60"}]}

      _input = Map.from_struct(%ExKeyCDN.Report{})

      ExKeyCDN.MockHTTP
      |> expect(:request, fn :get, "reports/statestats.json", _input -> mocked end)

      assert ExKeyCDN.Report.status(%ExKeyCDN.Report{}) == expected
    end

    test "mock http and error" do
      expected = {:error, :forbidden}

      ExKeyCDN.MockHTTP
      |> expect(:request, fn :get, "reports/statestats.json", %{} -> expected end)

      assert ExKeyCDN.Report.status(%ExKeyCDN.Report{}) == expected
    end

    test "mock http and not successfull" do
      expected = {:error, "error message"}
      mocked = {:ok, %{"status" => "error", "description" => "error message"}, []}

      ExKeyCDN.MockHTTP
      |> expect(:request, fn :get, "reports/statestats.json", %{} -> mocked end)

      assert ExKeyCDN.Report.status(%ExKeyCDN.Report{}) == expected
    end
  end

  describe "credit/1" do
    test "mock" do
      expected = [
        stats: [%ExKeyCDN.CreditStatistic{}, %ExKeyCDN.CreditStatistic{}],
        limits: [rate_limit_remaining: "60", rate_limit: "60"]
      ]

      input = Map.from_struct(%ExKeyCDN.Report{})

      ExKeyCDN.MockReport
      |> expect(:credit, fn _input -> expected end)

      assert report().credit(input) == expected
    end

    test "mock http and ok" do
      expected = [
        stats: [],
        limits: [rate_limit_remaining: "60", rate_limit: "60"]
      ]

      mocked =
        {:ok, %{"data" => [], "status" => "success", "description" => "good work"},
         [{"X-Rate-Limit-Limit", "60"}, {"X-Rate-Limit-Remaining", "60"}]}

      _input = Map.from_struct(%ExKeyCDN.Report{})

      ExKeyCDN.MockHTTP
      |> expect(:request, fn :get, "reports/credits.json", _input -> mocked end)

      assert ExKeyCDN.Report.credit(%ExKeyCDN.Report{}) == expected
    end

    test "mock http and error" do
      expected = {:error, :forbidden}

      ExKeyCDN.MockHTTP
      |> expect(:request, fn :get, "reports/credits.json", %{} -> expected end)

      assert ExKeyCDN.Report.credit(%ExKeyCDN.Report{}) == expected
    end

    test "mock http and not successfull" do
      expected = {:error, "error message"}
      mocked = {:ok, %{"status" => "error", "description" => "error message"}, []}

      ExKeyCDN.MockHTTP
      |> expect(:request, fn :get, "reports/credits.json", %{} -> mocked end)

      assert ExKeyCDN.Report.credit(%ExKeyCDN.Report{}) == expected
    end
  end

  defp report do
    Application.get_env(:exkeycdn, :report)
  end
end
