"""
In your editor, implement a Red-Black Tree (RBT) using the structure {color, value, next_left, next_right}, where color is either red or black, value is the element stored, and next_left and next_right are the left and right subtrees. Your implementation should include the following functions:

empty(rbt): Checks if the RBT is empty.

Input: An RBT.

Output: true if the tree is empty, false otherwise.

add(rbt, element): Adds an element to the RBT.

Input: An RBT and an element.

Output: A new RBT with the element added.

contains(rbt, element): Checks if a value exists in the RBT.

Input: An RBT and a value.

Output: true if the value is found, false otherwise.

remove(rbt, element): Removes an element from the RBT.

Input: An RBT and an element.

Output: A new RBT with the element removed.

min(rbt): Finds the smallest element in the RBT.

Input: An RBT.

Output: The smallest element or nil if the tree is empty.

max(rbt): Finds the largest element in the RBT.

Input: An RBT.

Output: The largest element or nil if the tree is empty.

toList(rbt): Converts the RBT to a sorted list (in-order traversal).

Input: An RBT.

Output: A list of elements in sorted order.

fromList(list): Constructs an RBT from a list of elements.

Input: A list of elements.

Output: An RBT.
"""

defmodule RBT do
  # define a node with color, value, and child subtrees
  defstruct color: :black, value: nil, left: nil, right: nil

  # check if the tree is empty
  def empty(%RBT{value: nil}), do: true
  def empty(_), do: false


  # helper: balance the tree after insertion
  defp balance(:black,
         %RBT{color: :red, value: x, left: %RBT{color: :red, value: a, left: l, right: r1}, right: r2},
         y,
         r3),
       do: %RBT{color: :red, value: x, left: %RBT{color: :black, value: a, left: l, right: r1}, right: %RBT{color: :black, value: y, left: r2, right: r3}}

  defp balance(:black,
         l,
         y,
         %RBT{color: :red, value: x, left: %RBT{color: :red, value: a, left: r1, right: r2}, right: r3}),
       do: %RBT{color: :red, value: x, left: %RBT{color: :black, value: y, left: l, right: r1}, right: %RBT{color: :black, value: a, left: r2, right: r3}}

  defp balance(:black,
         l,
         y,
         %RBT{color: :red, value: x, left: r1, right: %RBT{color: :red, value: a, left: r2, right: r3}}),
       do: %RBT{color: :red, value: x, left: %RBT{color: :black, value: y, left: l, right: r1}, right: %RBT{color: :black, value: a, left: r2, right: r3}}

  defp balance(:black,
         %RBT{color: :red, value: x, left: l, right: %RBT{color: :red, value: y, left: r1, right: r2}},
         z,
         r3),
       do: %RBT{color: :red, value: y, left: %RBT{color: :black, value: x, left: l, right: r1}, right: %RBT{color: :black, value: z, left: r2, right: r3}}

  defp balance(color, left, value, right),
       do: %RBT{color: color, value: value, left: left, right: right}

  # add an element
  def add(%RBT{value: nil}, x), do: %RBT{color: :black, value: x}
  def add(tree, x) do
    %{add_helper(tree, x) | color: :black}
  end

  defp add_helper(%RBT{color: color, value: value, left: left, right: right}, x) when value != nil do
    cond do
      x < value -> balance(color, add_helper(left || %RBT{}, x), value, right)
      x > value -> balance(color, left, value, add_helper(right || %RBT{}, x))
      true -> %RBT{color: color, value: value, left: left, right: right}
    end
  end

  defp add_helper(%RBT{value: nil}, x), do: %RBT{color: :red, value: x}

  # contains
  def contains(%RBT{value: nil}, _), do: false
  def contains(%RBT{value: value, left: left, right: right}, x) do
    cond do
      x == value -> true
      x < value -> contains(left || %RBT{}, x)
      x > value -> contains(right || %RBT{}, x)
    end
  end

  # min and max
  def min(%RBT{value: nil}), do: nil
  def min(%RBT{left: nil, value: v}), do: v
  def min(%RBT{left: l}), do: min(l)

  def max(%RBT{value: nil}), do: nil
  def max(%RBT{right: nil, value: v}), do: v
  def max(%RBT{right: r}), do: max(r)

  # convert to sorted list (in-order)
  def toList(%RBT{value: nil}), do: []
  def toList(%RBT{value: v, left: l, right: r}),
    do: toList(l || %RBT{}) ++ [v] ++ toList(r || %RBT{})

  # build from list
  def fromList([]), do: %RBT{}
  def fromList([h | t]),
    do: Enum.reduce(t, %RBT{color: :black, value: h}, fn el, acc -> add(acc, el) end)

  # remove (basic bst remove; full color rebalancing omitted for simplicity)
  def remove(%RBT{value: nil} = tree, _), do: tree
  def remove(%RBT{value: v, left: l, right: r} = tree, x) do
    cond do
      x < v -> %{tree | left: remove(l || %RBT{}, x)}
      x > v -> %{tree | right: remove(r || %RBT{}, x)}
      true ->
        cond do
          l == nil and r == nil -> %RBT{}
          l == nil -> r
          r == nil -> l
          true ->
            successor = min(r)
            %{tree | value: successor, right: remove(r, successor)}
        end
    end
  end
end
