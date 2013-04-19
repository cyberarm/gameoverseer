class GameOverseer
  CONFIG = {
    ip_address: "localhost",
    port: 67281,
    max_players: 16,
    key_generator_method: 'hex', # SecureRandom module
    logger_directory: 'logs'
  }
end