defmodule Freecodecamp.BasicAlgo do
  # @type word() :: String.t()

  @moduledoc """
  Documentation for Freecodecamp (Basic Alogrithmic Scripting).
  """

  @doc """
  Convert Celsius to Fahrenheit

  ## Examples

      iex> BasicAlgo.convert_to_f(30)
      86

  """
  @spec convert_to_f(integer) :: integer
  def convert_to_f(celsius \\ 0) when is_integer(celsius), do: div(celsius * 9, 5) + 32

  @doc """
  Reverses a string

  ## Examples

      iex> BasicAlgo.reverse_string("hello")
      "olleh"

  """
  @spec reverse_string(String.t()) :: String.t()
  defdelegate reverse_string(str), to: String, as: :reverse

  @doc """
  Factorialize a number

  ## Examples

      iex> BasicAlgo.factorialize(0)
      1

      iex> BasicAlgo.factorialize(5)
      120

  """
  @spec factorialize(integer) :: integer
  def factorialize(0), do: 1
  def factorialize(n) when is_integer(n), do: n * factorialize(n - 1)

  @doc """
  Find the longest word and returns the length of it

  ## Examples

      iex> BasicAlgo.find_longest_wordlength("")
      0

      iex> BasicAlgo.find_longest_wordlength("May the force be with you")
      5

  """
  @spec find_longest_wordlength(String.t()) :: integer
  def find_longest_wordlength(""), do: 0

  def find_longest_wordlength(str) when is_binary(str) do
    str |> String.split() |> Enum.max_by(&String.length(&1)) |> String.length()
  end

  @doc """
  Return largest numbers in lists

  ## Examples

      iex> BasicAlgo.largest_of_four([])
      []

      iex> BasicAlgo.largest_of_four([[17, 23, 25, 12], [25, 7, 34, 48], [4, -10, 18, 21], [-72, -3, -17, -10]])
      [25, 48, 21, -3]

  """
  @spec largest_of_four(list(integer)) :: integer
  def largest_of_four(list), do: Enum.map(list, &Enum.max/1)

  @doc """
  Return repeated string

  ## Examples

      iex> BasicAlgo.repeat_string_num_times("abc", 2)
      "abcabc"

      iex> BasicAlgo.repeat_string_num_times("abc", 0)
      ""
      
      iex> BasicAlgo.repeat_string_num_times("abc", -1)
      ""

  """
  @spec repeat_string_num_times(String.t(), integer) :: String.t()
  def repeat_string_num_times(_string, num) when num <= 0, do: ""
  def repeat_string_num_times("", _num), do: ""
  def repeat_string_num_times(string, 1), do: string

  def repeat_string_num_times(string, num) when num > 1 do
    string <> repeat_string_num_times(string, num - 1)
  end

  @doc """
  Returns true if the string in the first element of the array
  contains all of the letters of the string in the second
  element of the array.

  ## Examples

      iex> BasicAlgo.mutation(["hello", "Hey"])
      false

      iex> BasicAlgo.mutation(["hello", "neo"])
      false
      
      iex> BasicAlgo.mutation(["Noel", "Ole"])
      true

  """
  @spec mutation(list(String.t())) :: boolean()
  def mutation(["", ""]), do: false
  def mutation(["", _source]), do: false
  def mutation([_target, ""]), do: false

  def mutation([target, source] = _list) do
    list =
      &(String.downcase(&1)
        |> String.split("", trim: true)
        |> Enum.uniq()
        |> Enum.sort())

    new_list = list.(target) |> Enum.filter(&(&1 in list.(source)))

    new_list == list.(source)
  end

  @doc """
  Truncate a string (first argument) if it is longer than
  the given maximum string length (second argument). Return
  the truncated string with a `...` ending.

  ## Examples

      iex> BasicAlgo.truncate_string("A-tisket a-tasket A green and yellow basket", 8)
      "A-tisket..."

      iex> BasicAlgo.truncate_string("Absolutely Longer", 2)
      "Ab..."
      
      iex> BasicAlgo.truncate_string("A-", 1)
      "A..."

      iex> BasicAlgo.truncate_string("A-tisket", -1)
      "..."

      iex> BasicAlgo.truncate_string("Hello", 50)
      "Hello..."

  """
  @spec truncate_string(String.t(), integer) :: String.t()
  def truncate_string(_words, len) when len <= 0, do: "..."
  def truncate_string("", _len), do: "..."

  def truncate_string(words, len) do
    case String.length(words) < len do
      true ->
        words <> "..."

      false ->
        words
        |> String.to_charlist()
        |> do_truncate_string(len)
        |> to_string()
        |> Kernel.<>("...")
    end
  end

  defp do_truncate_string(_letter, 0), do: []

  defp do_truncate_string([head | tails] = _list, len),
    do: [[head] | do_truncate_string(tails, len - 1)]
end
