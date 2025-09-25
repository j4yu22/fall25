"""
In your editor, write a stateless process that checks if a string is a palindrome.
"""

defmodule Palindrome do
  def main do
    word =
      IO.gets("Enter a word: ")
      |> String.trim()

    cleaned =
      word
      |> String.downcase()
      |> String.replace(~r/[^a-z0-9]/, "")

    if cleaned == String.reverse(cleaned) do
      IO.puts("#{word} is a palindrome.")
    else
      IO.puts("#{word} is not a palindrome.")
    end
  end
end

Palindrome.main()
