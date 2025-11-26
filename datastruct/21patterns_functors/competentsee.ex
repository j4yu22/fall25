"""
In your editor, define a functor for a dictionary (key-value pairs). Write a map function to apply a lambda to each value while keeping the keys unchanged.
"""
defmodule DictFunctor do
  @doc """
  Applies a function to every value in the dictionary while keeping keys unchanged.
  """
  def fmap(dict, fun) when is_map(dict) and is_function(fun, 1) do
    dict
    |> Enum.map(fn {k, v} -> {k, fun.(v)} end)
    |> Enum.into(%{})
  end
end

# --- test ---

dict = %{a: 1, b: 2, c: 3}

result =
  DictFunctor.fmap(dict, fn v -> v * 10 end)

IO.inspect(result)
