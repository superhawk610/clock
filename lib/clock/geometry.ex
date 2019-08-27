defmodule Clock.Geometry do
  @dot_count 60

  def points, do: 1..@dot_count |> Enum.map(&rotation_for/1)

  def rotation_for(idx, dot_count \\ @dot_count), do: "#{deg_of_separation(dot_count) * idx}deg"

  defp deg_of_separation(dot_count), do: 360 / dot_count
end
