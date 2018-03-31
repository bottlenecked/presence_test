defmodule PresenceTestTest do
  use ExUnit.Case
  doctest PresenceTest

  test "greets the world" do
    assert PresenceTest.hello() == :world
  end
end
