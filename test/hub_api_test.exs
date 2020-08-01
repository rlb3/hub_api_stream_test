defmodule HUBApiTest do
  use ExUnit.Case
  doctest HUBApi

  test "greets the world" do
    assert HUBApi.hello() == :world
  end
end
