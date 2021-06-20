defmodule NxMicroBenchTest do
  use ExUnit.Case
  doctest NxMicroBench

  test "greets the world" do
    assert NxMicroBench.hello() == :world
  end
end
