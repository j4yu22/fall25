"""
In your editor, implement the following functions for a Trie data structure:

Functional Requirements

empty(trie):

Input: A Trie.

Output: true if the Trie is empty, false otherwise.

add(trie, sequence):

Input: A Trie and a sequence (e.g., a string or list).

Output: A new Trie with the sequence added.

contains(trie, sequence):

Input: A Trie and a sequence.

Output: true if the sequence is found, false otherwise.

remove(trie, sequence):

Input: A Trie and a sequence.

Output: A new Trie with the sequence removed.

prefix(trie, prefix):

Input: A Trie and a prefix.

Output: A list of sequences that start with the prefix.

toList(trie):

Input: A Trie.

Output: A list of all sequences stored in the Trie.

fromList(list):

Input: A list of sequences.

Output: A Trie.
"""

defmodule Trie do
  # each node is a map with two keys:
  # :end? - marks if a complete sequence ends here
  # :children - holds a map of next characters to child nodes
  defstruct end?: false, children: %{}

  # check if the trie is empty
  def empty(%Trie{end?: false, children: children}), do: map_size(children) == 0
  def empty(_), do: false

  # add a sequence
  def add(trie, []), do: %{trie | end?: true}
  def add(%Trie{children: children} = trie, [h | t]) do
    updated_child = add(Map.get(children, h, %Trie{}), t)
    %{trie | children: Map.put(children, h, updated_child)}
  end
  def add(trie, sequence), do: add(trie, String.to_charlist(sequence))

  # check if a sequence exists
  def contains(%Trie{end?: end?, children: _}, []), do: end?
  def contains(%Trie{children: children}, [h | t]) do
    case Map.get(children, h) do
      nil -> false
      subtrie -> contains(subtrie, t)
    end
  end
  def contains(trie, sequence), do: contains(trie, String.to_charlist(sequence))

  # remove a sequence
  def remove(%Trie{} = trie, []), do: %{trie | end?: false}
  def remove(%Trie{children: children} = trie, [h | t]) do
    case Map.get(children, h) do
      nil -> trie
      subtrie ->
        new_sub = remove(subtrie, t)
        updated_children =
          if empty(new_sub) and !new_sub.end? do
            Map.delete(children, h)
          else
            Map.put(children, h, new_sub)
          end
        %{trie | children: updated_children}
    end
  end
  def remove(trie, sequence), do: remove(trie, String.to_charlist(sequence))

  # list all words starting with a given prefix
  def prefix(trie, prefix) do
    case follow(trie, String.to_charlist(prefix)) do
      nil -> []
      node -> collect(node, prefix)
    end
  end

  defp follow(%Trie{} = trie, []), do: trie
  defp follow(%Trie{children: children}, [h | t]) do
    case Map.get(children, h) do
      nil -> nil
      node -> follow(node, t)
    end
  end

  # list all sequences in trie
  def toList(trie), do: collect(trie, "")

  defp collect(%Trie{end?: end?, children: children}, prefix) do
    current = if end?, do: [prefix], else: []
    child_words =
      children
      |> Enum.flat_map(fn {k, v} -> collect(v, prefix <> <<k>>) end)
    current ++ child_words
  end

  # build trie from list
  def fromList(list) do
    Enum.reduce(list, %Trie{}, fn seq, acc -> add(acc, seq) end)
  end
end
