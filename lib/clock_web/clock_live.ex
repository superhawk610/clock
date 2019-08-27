defmodule ClockWeb.ClockLive do
  use Phoenix.LiveView

  def render(assigns) do
    ~L"""
    <div class="clock">
      <div class="label"><%= @now %></div>
      <div class="outline"></div>
      <div class="arm-minute" style="transform: rotate(<%= @minute %>)"></div>
      <div class="arm-hour" style="transform: rotate(<%= @hour %>)"></div>
      <%= for point <- @points do %>
        <div class="arm" style="transform: rotate(<%= point %>)">
          <div class="point"></div>
        </div>
      <% end %>
      <div class="center"></div>
    </div>
    """
  end

  def mount(_session, socket) do
    if connected?(socket), do: :timer.send_interval(1000, self(), :tick)

    now = NaiveDateTime.utc_now()
    {:ok, assign(socket,
      now: humanize(now),
      hour: Clock.Geometry.rotation_for(now.hour, 12),
      minute: Clock.Geometry.rotation_for(now.minute),
      points: get_points(now))}
  end

  def handle_info(:tick, socket) do
    now = NaiveDateTime.utc_now()
    {:noreply, assign(socket,
      now: humanize(now),
      hour: Clock.Geometry.rotation_for(now.hour, 12),
      minute: Clock.Geometry.rotation_for(now.minute),
      points: get_points(now))}
  end

  defp get_points(time) do
    Clock.Geometry.points()
    |> Enum.take(time.second)
  end

  defp humanize(time) do
    am_pm = if time.hour < 12, do: "AM", else: "PM"
    "#{time.hour}:#{pad(time.minute)}:#{pad(time.second)} #{am_pm}"
  end

  defp pad(n) when n in 0..9, do: "0#{n}"
  defp pad(n), do: "#{n}"
end
