"""
In your editor, implement the following queue functionality using the structure {list, list}:

empty(queue)

Input: A queue.

Output: true if the queue is empty, false otherwise.

enqueue(queue, element)

Input: A queue and an element.

Output: A new queue with the element added.

dequeue(queue)

Input: A queue.

Output: A new queue with the first element removed.

head(queue)

Input: A queue.

Output: The first element or nil if the queue is empty.

tail(queue)

Input: A queue.

Output: The last element or nil if the queue is empty.

toList(queue)

Input: A queue.

Output: A list of elements in order.

fromList(list)

Input: A list of elements.

Output: A queue.
"""

defmodule Queue do
  # create an empty queue
  def empty({[], []}), do: true
  def empty(_), do: false

  # add element to the queue
  def enqueue({front, back}, element), do: {front, [element | back]}

  # remove the first element from the queue
  def dequeue({[], []}), do: {[], []}
  def dequeue({[], back}), do: dequeue({Enum.reverse(back), []})
  def dequeue({[_ | rest], back}), do: {rest, back}

  # return the first element
  def head({[], []}), do: nil
  def head({[], back}), do: back |> Enum.reverse() |> hd()
  def head({[h | _], _}), do: h

  # return the last element
  def tail({[], []}), do: nil
  def tail({[], back}), do: hd(back)
  def tail({front, []}), do: List.last(front)
  def tail({_, back}), do: hd(back)

  # convert queue to list
  def toList({front, back}), do: front ++ Enum.reverse(back)

  # create queue from list
  def fromList(list), do: {list, []}
end
