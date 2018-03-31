defmodule PresenceTest.Application do
  use Application

  def start(_, _) do
    import Supervisor.Spec, warn: false
    [
      supervisor(Phoenix.PubSub.PG2, [PresenceTest.PubSub, []]),
      PresenceTest.Presence,
      PresenceTest.NodeManager
    ]
    |> Supervisor.start_link([strategy: :one_for_one, name: PresenceTest.Supervisor])
  end
end
