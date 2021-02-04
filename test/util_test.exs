defmodule ExKeyCDN.UtilTest do
  use ExUnit.Case, async: true
  alias ExKeyCDN.Util

  doctest ExKeyCDN.Util

  describe "successfull?/1" do
    test "successfull" do
      input = %{"status" => "success", "description" => "good work"}
      assert Util.successfull?(input) == {true, input}
    end

    test "not successfull" do
      input = %{"status" => "giberish", "description" => "error example"}
      assert Util.successfull?(input) == {false, "error example"}
    end

    test "not expected keys" do
      assert Util.successfull?(%{}) ==
               {false,
                "API changed, :ok resopnse body does not contain status and description keys."}
    end
  end

  describe "map_to_keywordlist/1" do
    test "ok" do
      input = %{"status" => "success", "description" => "good work"}
      assert Util.map_to_keywordlist(input) == [description: "good work", status: "success"]
    end

    test "not a map" do
      input = "status"

      assert_raise ArgumentError, "not a map in response list", fn ->
        Util.map_to_keywordlist(input)
      end
    end
  end

  describe "get_limits/1" do
    test "ok" do
      input = [
        {"X-Rate-Limit-Limit", "60"},
        {"X-Rate-Limit-Remaining", "60"},
        {"a", "b"}
      ]

      assert Util.get_limits(input) == [rate_limit_remaining: "60", rate_limit: "60"]
    end

    test "no headers" do
      input = [
        {"X-Rate------Limit-Limit", "60"},
        {"X-Rate-Limit----Remaining", "60"}
      ]

      assert Util.get_limits(input) == [rate_limit_remaining: :not_sent, rate_limit: :not_sent]
    end
  end

  describe "map_to_struct/3" do
    test "empty list" do
      assert Util.map_to_struct([], Enum.Map, "") == []
    end

    test "data key value not sent" do
      assert Util.map_to_struct(%{"wrong key" => [%{"name" => "karlo"}]}, ExKeyCDN.Zone, "zone") ==
               {:error, "API changed or data key value did not sent."}
    end

    test "with map" do
      assert Util.map_to_struct(%{"zone" => %{"name" => "karlo"}}, ExKeyCDN.Zone, "zone") ==
               %ExKeyCDN.Zone{
                 name: "karlo",
                 type: "push",
                 cachestripcookies: "disabled",
                 cachehostheader: "disabled",
                 cacheignorequerystring: "enabled",
                 cacheerrorpages: "disabled",
                 cacherobots: "disabled",
                 cachekeywebp: "disabled",
                 cors: "disabled",
                 imgproc: "disabled",
                 forcessl: "disabled",
                 customsslkey: "valid key",
                 cachecookies: "disabled",
                 securetoken: "disabled",
                 blockbadbots: "disabled",
                 status: "active",
                 allowemptyreferrer: "enabled",
                 cachekeydevice: "disabled",
                 dirlist: "disabled",
                 originshield: "disabled",
                 cacheignorecachecontrol: "enabled",
                 cachekeyscheme: "disabled",
                 gzip: "disabled",
                 expire: 0,
                 customsslcert: "valid cert",
                 blockreferrer: "disabled",
                 id: nil,
                 securetokenkey: "",
                 cachekeyhost: "disabled",
                 sslcert: :shared,
                 cachexpullkey: "ExKeyCDN",
                 cachebr: "disabled",
                 cachecanonical: "disabled",
                 originurl: "https://example.com",
                 forcedownload: "disabled",
                 cachemaxexpire: 1440,
                 cachekeycookie: "alphanumeric32charachters"
               }
    end

    test "with list" do
      assert Util.map_to_struct(%{"zones" => [%{"name" => "karlo"}]}, ExKeyCDN.Zone, "zones") == [
               %ExKeyCDN.Zone{
                 name: "karlo",
                 type: "push",
                 imgproc: "disabled",
                 customsslkey: "valid key",
                 originshield: "disabled",
                 securetokenkey: "",
                 cachecanonical: "disabled",
                 cachekeydevice: "disabled",
                 cachekeycookie: "alphanumeric32charachters",
                 cacherobots: "disabled",
                 customsslcert: "valid cert",
                 originurl: "https://example.com",
                 cachexpullkey: "ExKeyCDN",
                 cors: "disabled",
                 cachebr: "disabled",
                 cachekeyscheme: "disabled",
                 cachekeywebp: "disabled",
                 cachecookies: "disabled",
                 cachemaxexpire: 1440,
                 securetoken: "disabled",
                 cacheerrorpages: "disabled",
                 cachestripcookies: "disabled",
                 cachekeyhost: "disabled",
                 sslcert: :shared,
                 status: "active",
                 allowemptyreferrer: "enabled",
                 gzip: "disabled",
                 id: nil,
                 blockreferrer: "disabled",
                 cacheignorecachecontrol: "enabled",
                 forcessl: "disabled",
                 expire: 0,
                 forcedownload: "disabled",
                 dirlist: "disabled",
                 cachehostheader: "disabled",
                 blockbadbots: "disabled",
                 cacheignorequerystring: "enabled"
               }
             ]
    end
  end
end
