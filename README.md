# PresenceTest

This is a proof of concept project to check the viability of phoenix presence as state tracking mechanism in a cluster.

## What it does
It creates a simple GenServer process (`NodeManager.ex`) on every started node that listens for phoenix presence messages (leaves/joins)

## How to use
Start a few nodes on your machine, eg
```bash
#on console window 1
iex --sname a -S mix
```

```bash
#on console window 2
iex --sname b -S mix
```

Then from `console window 1 enter:`
```elixir
Node.connect :"b@YOUR-COMPUTER-NAME"
PresenceTest.NodeManager.track_customer(1)
PresenceTest.NodeManager.track_customer(2)
PresenceTest.NodeManager.untrack_customer(2) #ideally this line produces no notifications or there is some way to differentiate between drops and untracks
```
What you should be seeing is messages printed in each console window (from `NodeManager.handle_info/2`) that notify of leaves and joins in a cluster.
_You could also try exiting (CTRL+C x 2) the node on console 1 and see the leave diff popping up in console 2_

