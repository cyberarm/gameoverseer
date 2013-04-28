require "bundler"
Bundler.require(:default)
Bundler.require(:gui)
require_relative "../version"
require_relative "../chat/chatmanager"
require_relative "../service/servicemanager"

class GameOverseerManager < Shoes
  url '/', :overview
  url '/chat', :chat
  url '/server', :server

  def initialize
    super
    @messages = []
  end

  def overview
    layout

    subtitle "Overview"
  end

  def chat
    layout

    subtitle "Chat"
    message_box = stack height: 500 do
    end

    flow do
      chatbar = edit_line ""
      button "Send" do
        @messages << chatbar.text
        message_box.append do
          para "#{chatbar.text}"
        end
        chatbar.text = ""
      end
    end
  end

  def server
    layout

    subtitle "Server"
  end

  def layout(header = "GameOverseerV#{GameOverseer::VERSION} (#{GameOverseer::VERSION_NAME})")
    stack width: '100%' do
      stack do
        background white..blue
        subtitle "#{header}", stroke: white, weight: 'heavy'
      end

      flow do
        button "Overview" do
          visit "/"
        end

        button "Chat" do
          visit "/chat"
        end

        button "Server" do
          visit "/server"
        end

        button "Quit" do
          close
          exit
        end
      end
    end
  end
end

Shoes.app width: 1080, height: 720 do
  visit "/"
end