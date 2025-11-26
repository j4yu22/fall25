"""
In your editor, use the Maybe monad to safely handle division. Return Nothing if division by zero is attempted.
"""
defmodule Maybe do
  defmodule Just do
    defstruct [:value]
  end

  defmodule Nothing do
    defstruct []
  end

  @doc """
  Monad bind: applies `fun` only if value is Just.
  """
  def bind(%Just{value: v}, fun), do: fun.(v)
  def bind(%Nothing{}, _fun), do: %Nothing{}
end

defmodule SafeMath do
  alias Maybe.{Just, Nothing}

  @doc """
  Safe division using Maybe:
  returns Just(result) or Nothing on divide-by-zero.
  """
  def divide(_a, 0), do: %Nothing{}
  def divide(a, b),   do: %Just{value: a / b}
end

# --- tests ---

alias Maybe.{Just, Nothing}

IO.inspect SafeMath.divide(10, 2)      # %Just{value: 5.0}
IO.inspect SafeMath.divide(10, 0)      # %Nothing{}

# Using bind to chain operations:
result =
  SafeMath.divide(20, 2)
  |> Maybe.bind(fn x -> SafeMath.divide(x, 2) end)

IO.inspect result
