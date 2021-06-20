defmodule NxMicroBench do
  @moduledoc """
  Documentation for `NxMicroBench`.
  """

  def round_pow(l, s) do
    Enum.map(l, &round(&1 * Integer.pow(2, s)))
  end
end
