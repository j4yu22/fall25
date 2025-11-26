"""
In your editor, implement the following scenario from the Lazy Computation Pattern topic:

Write a lazy function that generates an infinite sequence of alternating positive and negative integers (e.g., 1, -2, 3, -4, ...), one at a time. Test it by retrieving the first 6 numbers.
"""
defmodule LazyAlternating do
  @doc """
  Returns a lazy stream of alternating positive and negative integers:
  1, -2, 3, -4, 5, -6, ...
  """
  def alternating_stream() do
    Stream.iterate(1, &(&1 + 1))
    |> Stream.map(fn n ->
      if rem(n, 2) == 0 do
        -n
      else
        n
      end
    end)
  end
end

# --- test ---

first_six =
  LazyAlternating.alternating_stream()
  |> Enum.take(6)

IO.inspect(first_six)
