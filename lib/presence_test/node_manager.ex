defmodule PresenceTest.NodeManager do
  use GenServer

  @name __MODULE__
  @topic "customers"
  alias PresenceTest.Presence

  def start_link(_) do
    GenServer.start_link(@name, [], name: @name)
  end

  @impl GenServer
  def init(_) do
    Phoenix.PubSub.subscribe(PresenceTest.PubSub, @topic)
    {:ok, %{}}
  end

  def track_customer(id) do
    Presence.track(self(), @topic, id, %{node: Node.self()})
  end

  def update_customer(id, data) do
    Presence.update(self(), @topic, id, data)
  end

  def untrack_customer(id) do
    pid = self()
    # untracking triggers leave message, we need to somehow differentiate from fallen nodes/abrupt exits
    Presence.untrack(pid, @topic, id)
  end

  @impl GenServer
  def handle_info(message, state) do
    IO.inspect(message, label: "node manager got")
    {:noreply, state}
  end

end