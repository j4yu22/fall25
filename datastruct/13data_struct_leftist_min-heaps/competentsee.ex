"""
Data CompetentSee said:

In your editor, implement the following functions for the Leftist Min-Heap data structure:

empty(heap)

Input: A Leftist Min-Heap.

Output: true if the heap is empty, false otherwise.

insert(heap, element)

Input: A Leftist Min-Heap and an element.

Output: A new Leftist Min-Heap with the element inserted.

findMin(heap)

Input: A Leftist Min-Heap.

Output: The minimum element (at the root) without modifying the heap.

deleteMin(heap)

Input: A Leftist Min-Heap.

Output: A new Leftist Min-Heap with the minimum element removed.

merge(heap1, heap2)

Input: Two Leftist Min-Heaps.

Output: A new Leftist Min-Heap that contains all elements from both input heaps.

toList(heap)

Input: A Leftist Min-Heap.

Output: A list of elements sorted in ascending order.

fromList(list)

Input: A standard list of elements.

Output: A Leftist Min-Heap containing all the elements.
"""
defmodule LeftistHeap do
  @moduledoc """
  Leftist Min-Heap implementation.
  """

  # A node looks like:
  # %{value: x, left: left_sub, right: right_sub, npl: npl}

  @type heap :: nil | %{value: any(), left: heap, right: heap, npl: non_neg_integer()}


  # ----------------------------------------------------
  # empty/1
  # ----------------------------------------------------
  def empty(nil), do: true
  def empty(_), do: false


  # ----------------------------------------------------
  # merge/2   (core operation)
  # ----------------------------------------------------
  def merge(nil, h2), do: h2
  def merge(h1, nil), do: h1

  def merge(h1 = %{value: v1}, h2 = %{value: v2}) do
    if v1 <= v2 do
      merge_roots(h1, h2)
    else
      merge_roots(h2, h1)
    end
  end

  defp merge_roots(root, other) do
    new_right = merge(root.right, other)
    new_node = %{root | right: new_right}
    ensure_leftist(new_node)
  end

  defp ensure_leftist(node = %{left: l, right: r}) do
    # compute npl of children
    npl_l = npl(l)
    npl_r = npl(r)

    # swap if right has larger npl (leftist property)
    {left, right} =
      if npl_l < npl_r do
        {r, l}
      else
        {l, r}
      end

    %{value: node.value, left: left, right: right, npl: 1 + npl(right)}
  end

  defp npl(nil), do: 0
  defp npl(%{npl: npl}), do: npl


  # ----------------------------------------------------
  # insert/2
  # ----------------------------------------------------
  def insert(heap, value) do
    merge(heap, %{value: value, left: nil, right: nil, npl: 1})
  end


  # ----------------------------------------------------
  # findMin/1
  # ----------------------------------------------------
  def findMin(nil), do: nil
  def findMin(%{value: value}), do: value


  # ----------------------------------------------------
  # deleteMin/1
  # ----------------------------------------------------
  def deleteMin(nil), do: nil

  def deleteMin(%{left: l, right: r}) do
    merge(l, r)
  end


  # ----------------------------------------------------
  # toList/1
  # ----------------------------------------------------
  def toList(heap), do: toList(heap, [])

  defp toList(nil, acc), do: Enum.reverse(acc)
  defp toList(heap, acc) do
    min = findMin(heap)
    rest = deleteMin(heap)
    toList(rest, [min | acc])
  end


  # ----------------------------------------------------
  # fromList/1
  # ----------------------------------------------------
  def fromList(list) do
    Enum.reduce(list, nil, fn elem, heap ->
      insert(heap, elem)
    end)
  end
end
