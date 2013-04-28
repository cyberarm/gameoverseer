class GameOverseer
  # Configuration hash.
  CONFIG = {
    # IP address GameOverseer::Server will bind with.
    ip_address: "localhost",
    # Port GameOverseer::Server will bind with.
    port: 67281,
    # Max allowed players to join at one time.
    max_players: 16,
    # Directory the server will log into.
    logger_directory: 'logs',
    # Words that are filtered before being sent to players.
    banned_words: ["lol", "ftw"]
  }
end