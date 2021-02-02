defmodule ExKeyCDN.JsonEncoderTest do
  use ExUnit.Case, async: true

  test "encode a map" do
    assert ExKeyCDN.JsonEncoder.encode(%{name: "a nam:e"}) == "{\"name\":\"a nam:e\"}"
  end

  test "error" do
    assert ExKeyCDN.JsonEncoder.encode(%{name: "\xFF"}) ==
             {:error, "invalid byte 0xFF in <<255>>"}
  end

  test "not a map" do
    assert ExKeyCDN.JsonEncoder.encode(:name) == {:error, "Request body must be a map."}
  end
end
