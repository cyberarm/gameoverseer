class Sentinel < GameOverseer::Service
  #Service Setup
  # def new(*args)
  #   binding.pry
  #   super
  # end

  def initialize
    binding.pry
    @players = 0
    GameOverseer::ChannelManager.subscribe('chat', self)
  end

  #Setup
  def events
    [:on_join, :on_quit]
  end

  def commands
    [:kick, :ban, :server, :services]
  end

  def update(data)
    p "DATA: #{data}"
  end

  #Events
  def on_join(data)
    puts "#{data['username']} has joined the game."
  end

  def on_quit(data)
    puts "#{data['username']} has joined the game."
  end

  #Commands
  def kick(data)
    # ToDo: Do something.
  end

  def ban(data)
    # ToDo: Do something.
    data = data['message'].split(/ /)
    puts "Banned player #{data[1]}," if data[2]
    if data[2]
      data[2..data.count].each do |text|
        print "#{text} "
      end
    end
    puts "Banned player #{data[1]}, no reason given." unless data[2]
  end

  def server(data)
    #Todo: Ensure command giver has authority to run this command
    data = data['message'].split(/ /)
    if data[1].nil?
      "!server [exit|shutdown|stop|restart|status|players]" if data['console'] == true
    end

    case data[1]
    when /status/
      puts "players: #{@players}, Status: OK" if data['console'] == true

    when /exit|shutdown|stop/
      exit unless $testing
      true if $testing
    end
  end

  def services(data)
    # ToDo: Do something.
  end

  def version
    "0.0.1"
  end
end