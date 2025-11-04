"""
In your editor, implement a functional deque using the structure {list, list}. The deque must support operations from both ends and include the following functions:

empty(deque)

Input: A deque.

Output: true if the deque is empty, false otherwise.

enqueue(deque, element)

Input: A deque and an element.

Output: A new deque with the element added to the rear.

enqueue_front(deque, element)

Input: A deque and an element.

Output: A new deque with the element added to the front.

dequeue(deque)

Input: A deque.

Output: A new deque with the first element removed.

dequeue_back(deque)

Input: A deque.

Output: A new deque with the last element removed.

head(deque)

Input: A deque.

Output: The first element or nil if the deque is empty.

tail(deque)

Input: A deque.

Output: The last element or nil if the deque is empty.

toList(deque)

Input: A deque.

Output: A list of elements in order.

fromList(list)

Input: A list of elements.

Output: A deque.
"""

defmodule Deque do
  # check if deque is empty
  def empty({front, rear}), do: front == [] and rear == []

  # add element to the rear
  def enqueue({front, rear}, element), do: {front, [element | rear]}

  # add element to the front
  def enqueue_front({front, rear}, element), do: {[element | front], rear}

  # remove element from the front
  def dequeue({[], []}), do: {[], []}
  def dequeue({[], rear}), do: dequeue({Enum.reverse(rear), []})
  def dequeue({[_ | rest], rear}), do: {rest, rear}

  # remove element from the back
  def dequeue_back({[], []}), do: {[], []}
  def dequeue_back({front, []}), do: dequeue_back({[], Enum.reverse(front)})
  def dequeue_back({front, [_ | rest]}), do: {front, rest}

  # get first element
  def head({[], []}), do: nil
  def head({[], rear}), do: rear |> Enum.reverse() |> List.first()
  def head({front, _}), do: List.first(front)

  # get last element
  def tail({[], []}), do: nil
  def tail({front, []}), do: front |> Enum.reverse() |> List.first()
  def tail({_, rear}), do: List.first(rear)

  # convert deque to list
  def toList({front, rear}), do: front ++ Enum.reverse(rear)

  # create deque from list
  def fromList(list), do: {list, []}
end
