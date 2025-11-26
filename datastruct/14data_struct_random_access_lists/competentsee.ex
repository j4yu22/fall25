"""
In your editor, implement the following functions for the Random Access List:

empty(ralist):

Input: A Random Access List.

Output: true if the list is empty, false otherwise.

cons(element, ralist):

Input: An element and a Random Access List.

Output: A new Random Access List with the element added to the front.

head(ralist):

Input: A Random Access List.

Output: The first element.

tail(ralist):

Input: A Random Access List.

Output: The last element.

lookup(ralist, index):

Input: A Random Access List and an index.

Output: The element at the specified index.

Edge Case: Handle out-of-bounds indices properly.

update(ralist, index, newValue):

Input: A Random Access List, an index, and a new value.

Output: A new Random Access List with the specified element updated.

toList(ralist):

Input: A Random Access List.

Output: A list containing all elements in order.

fromList(list):

Input: A standard list.

Output: A Random Access List containing the same elements in order.
"""

defmodule RandomAccessList do
  @moduledoc """
  Random Access List implemented using skew-binary trees.
  """

  @type tree ::
          {:leaf, any()}
          | {:node, pos_integer(), tree(), tree()}

  @type ralist :: [tree()]


  # ----------------------------------------------------
  # empty/1
  # ----------------------------------------------------
  def empty([]), do: true
  def empty(_),  do: false


  # ----------------------------------------------------
  # cons/2  (prepend element)
  # ----------------------------------------------------
  def cons(x, [{:leaf, a}, {:leaf, b} | rest]) do
    # combine two leaf trees into one node
    new_tree = {:node, 2, {:leaf, x}, {:leaf, a}}
    [new_tree, {:leaf, b} | rest]
  end

  def cons(x, [t | rest]) do
    # if first tree is leaf but second is not leaf-leaf pair, do not combine
    [{:leaf, x}, t | rest]
  end

  def cons(x, []), do: [{:leaf, x}]


  # ----------------------------------------------------
  # head/1
  # ----------------------------------------------------
  def head([]), do: nil
  def head([{:leaf, x} | _]), do: x
  def head([{:node, _size, left, _right} | _]), do: head([left])


  # ----------------------------------------------------
  # tail/1
  # ----------------------------------------------------
  def tail([]), do: []
  def tail([{:leaf, _} | rest]), do: rest

  def tail([{:node, size, left, right} | rest]) do
    # split the node into two leaf-level pieces
    [{:leaf, extract(left)}, {:leaf, extract(right)} | rest]
  end

  defp extract({:leaf, v}), do: v
  defp extract({:node, _s, l, _r}), do: extract(l)


  # ----------------------------------------------------
  # lookup/2
  # ----------------------------------------------------
  def lookup(ralist, index), do: lookup_list(ralist, index)

  defp lookup_list([], _i), do: :out_of_bounds

  defp lookup_list([{:leaf, x} | _], 0), do: x
  defp lookup_list([{:leaf, _} | rest], i), do: lookup_list(rest, i - 1)

  defp lookup_list([{:node, size, left, right} | rest], i) do
    half = div(size, 2)

    cond do
      i < half -> lookup_tree(left, i)
      i < size -> lookup_tree(right, i - half)
      true -> lookup_list(rest, i - size)
    end
  end

  defp lookup_tree({:leaf, x}, 0), do: x
  defp lookup_tree({:leaf, _}, _), do: :out_of_bounds

  defp lookup_tree({:node, size, left, right}, i) do
    half = div(size, 2)

    if i < half do
      lookup_tree(left, i)
    else
      lookup_tree(right, i - half)
    end
  end


  # ----------------------------------------------------
  # update/3
  # ----------------------------------------------------
  def update(ralist, index, new_value) do
    update_list(ralist, index, new_value)
  end

  defp update_list([], _i, _v), do: :out_of_bounds

  defp update_list([{:leaf, _x} | rest], 0, v), do: [{:leaf, v} | rest]
  defp update_list([{:leaf, x} | rest], i, v) do
    updated_rest = update_list(rest, i - 1, v)
    if updated_rest == :out_of_bounds, do: :out_of_bounds, else: [{:leaf, x} | updated_rest]
  end

  defp update_list([{:node, size, left, right} | rest], i, v) do
    half = div(size, 2)

    cond do
      i < half ->
        updated_left = update_tree(left, i, v)
        if updated_left == :out_of_bounds do
          :out_of_bounds
        else
          [{:node, size, updated_left, right} | rest]
        end

      i < size ->
        updated_right = update_tree(right, i - half, v)
        if updated_right == :out_of_bounds do
          :out_of_bounds
        else
          [{:node, size, left, updated_right} | rest]
        end

      true ->
        updated_rest = update_list(rest, i - size, v)
        if updated_rest == :out_of_bounds, do: :out_of_bounds, else: [{:node, size, left, right} | updated_rest]
    end
  end

  defp update_tree({:leaf, _}, 0, v), do: {:leaf, v}
  defp update_tree({:leaf, _}, _i, _v), do: :out_of_bounds

  defp update_tree({:node, size, left, right}, i, v) do
    half = div(size, 2)

    cond do
      i < half ->
        updated = update_tree(left, i, v)
        if updated == :out_of_bounds, do: :out_of_bounds, else: {:node, size, updated, right}

      true ->
        updated = update_tree(right, i - half, v)
        if updated == :out_of_bounds, do: :out_of_bounds, else: {:node, size, left, updated}
    end
  end


  # ----------------------------------------------------
  # toList/1
  # ----------------------------------------------------
  def toList(ralist) do
    flatten(ralist, [])
  end

  defp flatten([], acc), do: Enum.reverse(acc)

  defp flatten([{:leaf, x} | rest], acc),
    do: flatten(rest, [x | acc])

  defp flatten([{:node, _size, left, right} | rest], acc) do
    acc2 = flatten_tree(left, acc)
    acc3 = flatten_tree(right, acc2)
    flatten(rest, acc3)
  end

  defp flatten_tree({:leaf, x}, acc), do: [x | acc]

  defp flatten_tree({:node, _s, left, right}, acc) do
    acc2 = flatten_tree(left, acc)
    flatten_tree(right, acc2)
  end


  # ----------------------------------------------------
  # fromList/1
  # ----------------------------------------------------
  def fromList(list) do
    Enum.reduce(list, [], fn x, acc -> cons(x, acc) end)
    |> Enum.reverse() # maintain original order
  end
end
