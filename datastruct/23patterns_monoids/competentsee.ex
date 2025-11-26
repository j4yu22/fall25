"""
In your editor, implement the following scenario from the Monoid pattern:

Scenario 13:
Implement a monoid for a pair (tuple) where both elements are combined using different operations (e.g., addition for the first and multiplication for the second).
"""
defmodule PairMonoid do
  @moduledoc """
  A monoid for pairs {a, b}:
    - first values combine with addition
    - second values combine with multiplication
  """

  @identity {0, 1}

  @doc """
  Returns the identity element for this monoid.
  """
  def identity, do: @identity

  @doc """
  Combines two pairs using the monoid rules:
    {a1, b1} <> {a2, b2} = {a1 + a2, b1 * b2}
  """
  def combine({a1, b1}, {a2, b2}) do
    {a1 + a2, b1 * b2}
  end

  @doc """
  Combines a list of pairs using the monoid.
  """
  def mconcat(list) do
    Enum.reduce(list, @identity, fn pair, acc ->
      combine(acc, pair)
    end)
  end
end

# --- tests ---

IO.inspect PairMonoid.combine({2, 3}, {4, 5})
# {6, 15}

IO.inspect PairMonoid.mconcat([{1, 2}, {3, 4}, {5, 6}])
# {9, 48}

IO.inspect PairMonoid.combine(PairMonoid.identity(), {10, 7})
# {10, 7}
