"""
In your editor, write a function to calculate the factorial of a number using recursion. Ensure the function is concise and uses meaningful names.
"""
defmodule Math do
  @doc """
  Returns the factorial of a non-negative integer n.
  """
  def factorial(0), do: 1

  def factorial(n) when n > 0 do
    n * factorial(n - 1)
  end
end
