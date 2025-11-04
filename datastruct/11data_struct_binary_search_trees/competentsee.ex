"""
In your editor, implement a Binary Search Tree (BST) using the structure {value, next_left, next_right}. Each node should consist of a value and references to the left and right subtrees. Implement the following functions:

empty(bst): Checks if the BST is empty.

Input: A BST.

Output: true if the BST is empty, false otherwise.

add(bst, element): Adds an element to the BST.

Input: A BST and an element.

Output: A new BST with the element added.

contains(bst, element): Checks if a value exists in the BST.

Input: A BST and a value.

Output: true if the value is found, false otherwise.

remove(bst, element): Removes an element from the BST.

Input: A BST and an element.

Output: A new BST with the element removed.

min(bst): Finds the smallest element in the BST.

Input: A BST.

Output: The smallest element or nil if the tree is empty.

max(bst): Finds the largest element in the BST.

Input: A BST.

Output: The largest element or nil if the tree is empty.

toList(bst): Converts the BST to a sorted list (in-order traversal).

Input: A BST.

Output: A list of elements in sorted order.

fromList(list): Constructs a BST from a list of elements.

Input: A list of elements.

Output: A BST.

height(bst): Computes the height of the BST.

Input: A BST.

Output: The height as an integer.

isBalanced(bst): Checks if the BST is balanced.

Input: A BST.

Output: true if the tree is balanced, false otherwise.
"""

defmodule BST do
  # define a simple struct for the binary search tree
  defstruct value: nil, left: nil, right: nil

  # check if the bst is empty
  def empty(%BST{value: nil, left: nil, right: nil}), do: true
  def empty(_), do: false

  # add a value to the bst
  def add(%BST{value: nil}, element), do: %BST{value: element}
  def add(%BST{value: value, left: left, right: right} = node, element) do
    cond do
      element < value -> %{node | left: add(left || %BST{}, element)}
      element > value -> %{node | right: add(right || %BST{}, element)}
      true -> node
    end
  end

  # check if the bst contains a value
  def contains(%BST{value: nil}, _), do: false
  def contains(%BST{value: value, left: left, right: right}, element) do
    cond do
      element == value -> true
      element < value -> contains(left || %BST{}, element)
      element > value -> contains(right || %BST{}, element)
    end
  end

  # find the minimum value in the bst
  def min(%BST{value: nil}), do: nil
  def min(%BST{left: nil, value: value}), do: value
  def min(%BST{left: left}), do: min(left)

  # find the maximum value in the bst
  def max(%BST{value: nil}), do: nil
  def max(%BST{right: nil, value: value}), do: value
  def max(%BST{right: right}), do: max(right)

  # remove a value from the bst
  def remove(%BST{value: nil} = node, _), do: node
  def remove(%BST{value: value, left: left, right: right} = node, element) do
    cond do
      element < value ->
        %{node | left: remove(left || %BST{}, element)}

      element > value ->
        %{node | right: remove(right || %BST{}, element)}

      true ->
        cond do
          left == nil and right == nil -> %BST{}
          left == nil -> right
          right == nil -> left
          true ->
            successor = min(right)
            %{node | value: successor, right: remove(right, successor)}
        end
    end
  end

  # convert bst to sorted list
  def toList(%BST{value: nil}), do: []
  def toList(%BST{value: value, left: left, right: right}) do
    (toList(left || %BST{}) ++ [value] ++ toList(right || %BST{}))
  end

  # build bst from list
  def fromList([]), do: %BST{}
  def fromList([h | t]) do
    Enum.reduce(t, %BST{value: h}, fn el, acc -> add(acc, el) end)
  end

  # compute height of bst
  def height(%BST{value: nil}), do: 0
  def height(%BST{left: left, right: right}) do
    1 + max(height(left || %BST{}), height(right || %BST{}))
  end

  # check if bst is balanced
  def isBalanced(%BST{value: nil}), do: true
  def isBalanced(%BST{left: left, right: right}) do
    left_height = height(left || %BST{})
    right_height = height(right || %BST{})
    abs(left_height - right_height) <= 1 and
      isBalanced(left || %BST{}) and
      isBalanced(right || %BST{})
  end
end
