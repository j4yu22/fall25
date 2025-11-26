"""
In your editor, write a factory function that generates a random integer within a specified range.
"""
defmodule NumberFactory do
  @doc """
  Returns a random integer between min and max (inclusive).
  """
  def random_integer(min, max) when min <= max do
    :rand.uniform(max - min + 1) + min - 1
  end
end
