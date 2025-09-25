"""
In your editor, create a variable to store a string and then assign its uppercase version to another variable.

In your editor, assign a tuple with mixed data types (e.g., an integer, atom, and string) to a variable and extract the string.

In your editor, construct a list by concatenating two smaller lists.

In your editor, use Enum.zip/2 to combine two lists into a list of tuples.
"""
# variable
lowercase_string = "albert"
uppercase_string = String.upcase(lowercase_string)
IO.puts("Lowercase String: #{lowercase_string}")
IO.puts("Uppercase String: #{uppercase_string}
")

# tuple
tuple = {37, :noun, "Bobert"}
string = elem(tuple, 2)
IO.puts("Original Tuple: #{inspect(tuple)}")
IO.puts("Extracted String from Tuple: #{string}
")

# list
list1 = [1, 2, 3]
list2 = [4, 5, 6]
big_list = list1 ++ list2
IO.puts("First List: #{inspect(list1)}")
IO.puts("Second List: #{inspect(list2)}")
IO.puts("Concatenated List: #{inspect(big_list)}
")

# list BIFs
list3 = ["a", "b", "c"]
list4 = [1, 2, 3]
combined_list = Enum.zip(list3, list4)
IO.puts("First List: #{inspect(list3)}")
IO.puts("Second List: #{inspect(list4)}")
IO.puts("Zipped List: #{inspect(combined_list)}
")
