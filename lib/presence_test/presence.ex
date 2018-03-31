defmodule PresenceTest.Presence do
  use Phoenix.Presence, otp_app: :presence_test,
                        pubsub_server: PresenceTest.PubSub

  #def fetch(_topic, presences), do: Map.keys(presences)
end
