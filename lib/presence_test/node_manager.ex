defmodule PresenceTest.NodeManager do
  use GenServer

  @name __MODULE__
  alias PresenceTest.Presence

  def start_link(_) do
    GenServer.start_link(@name, [], name: @name)
  end

  @impl GenServer
  def init(_) do
    Phoenix.PubSub.subscribe(PresenceTest.PubSub, "customers")
    {:ok, %{}}
  end

  def track_customer(id) do
    Presence.track(self(), "customers", id, %{node: Node.self()})
  end

  @impl GenServer
  def handle_info(message, state) do
    IO.inspect(message, label: "node manager got")
    {:noreply, state}
  end

end