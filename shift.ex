defmodule ShiftCipher do
  def encrypt(value, key) when key > 0 do
    shift(String.graphemes(value), :left, key)
  end

  def decrypt(value, key) when key > 0 do
    to_string(shift(value, :right, key))
  end

  defp shift([], direction, _) do
    cond do
      direction == :right or direction == :left ->
        []

      direction ->
        {:error}
    end
  end

  defp shift([a], direction, _) do
    cond do
      direction == :right or direction == :left ->
        [a]

      direction ->
        {:error}
    end
  end

  defp shift([head | tail], direction, 1) when is_atom(direction) and is_list([head | tail]) do
    cond do
      direction == :right ->
        [List.last(tail) | [head | tail |> Enum.reverse() |> tl() |> Enum.reverse()]]

      direction == :left ->
        tail ++ [head]

      direction ->
        {:error}
    end
  end

  defp shift([head | tail], direction, n)
       when is_atom(direction) and is_list([head | tail]) and n > 0 do
    cond do
      direction == :right ->
        shift(shift([head | tail], direction, 1), direction, n - 1)

      direction == :left ->
        shift(shift([head | tail], direction, 1), direction, n - 1)

      direction ->
        {:error}
    end
  end
end
