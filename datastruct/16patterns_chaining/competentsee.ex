"""
In your editor, write a chaining function that chains a set of functions so they convert a list of file paths into file names, sort them by extension, and remove duplicates.
"""
defmodule FileTools do
  @doc """
  Takes a list of file paths, extracts filenames,
  sorts them by extension, and removes duplicates.
  """
  def clean_file_list(paths) do
    paths
    |> Enum.map(&Path.basename/1)
    |> Enum.uniq()
    |> Enum.sort_by(&Path.extname/1)
  end
end
