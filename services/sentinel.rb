class Sentinel < GameOverseer::Service
  def initialize
    @players = 0
  end

  def events
    [:on_join, :on_quit]
  end

  def commands
    [:kick, :ban, :server]
  end

  def on_join(username)
    puts "{username} has joined the game."
  end

  def on_quit(username)
    puts "{username} has joined the game."
  end

  def kick(data)
    # ToDo: Do something.
  end

  def ban(data)
    # ToDo: Do something.
  end

  def server(data)
    # ToDo: Do something.
  end

  def version
    "0.0.1"
  end
end