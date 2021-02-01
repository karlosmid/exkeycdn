defmodule ExKeyCDN.EncoderTest do
  use ExUnit.Case, async: true

  test "encode a map" do
    assert ExKeyCDN.Encoder.encode(%{name: "a nam:e"}) == "name=a+nam%3Ae"
  end

  test "not a map" do
    assert ExKeyCDN.Encoder.encode(:name) == {:error, "Request body must be a map."}
  end
end
