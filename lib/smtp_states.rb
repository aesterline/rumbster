class NotInitializedError < RuntimeError; end

module State
  attr_accessor :protocol
  
  def serve(io)
    service_request(io)
  end  
end

module Messages
  
  def greeting(io)
    io.puts '220 ruby ESMTP'
  end
  
  def helo_response(io)
    io.puts '250 ruby'
  end
  
  def ok(io)
    io.puts '250 ok'
  end
  
  def go_ahead(io)
    io.puts '354 go ahead'
  end
  
  def goodbye(io)
    io.puts '221 ruby goodbye'
  end
  
end

class InitState
  
  include State, Messages
  
  def initialize(protocol = nil)
    @protocol = protocol
  end
  
  private
    
  def service_request(io)
    greeting(io)

    :connect
  end
  
end

class ConnectState
  
  include State, Messages

  def initialize(protocol = nil)
    @protocol = protocol
  end
    
  private
  
  def service_request(io)
    read_client_helo(io)
    helo_response(io)

    :connected
  end
  
  def read_client_helo(io)
    io.readline
  end
  
end

class ConnectedState
  
  include State, Messages
  
  def initialize(protocol = nil)
    @protocol = protocol
  end
  
  private
  
  def service_request(io)
    request = io.readline
    
    if request.strip.eql? "DATA"
      go_ahead(io)
      :read_mail
    else
      ok(io)
      :connected
    end
  end
  
end

class ReadMailState
  
  include State, Messages
  
  def initialize(protocol = nil)
    @protocol = protocol
  end
  
  private
  
  def service_request(io)
    message = read_message(io)
    @protocol.new_message_received(message)
    ok(io)

    :quit
  end
  
  def read_message(io)
    message = ''
    
    line = io.readline
    while not_end_of_message(line)
      message << line
      line = io.readline
    end
    
    message
  end

  def not_end_of_message(line)
    not line.strip.eql?('.')
  end
  
end

class QuitState
  
  include Messages
  attr_accessor :protocol
  
  def initialize(protocol = nil)
    @protocol = protocol
  end
  
  def serve(io)
    read_quit(io)
    goodbye(io)
    :done
  end
  
  private
  
  def read_quit(io)
    io.readline    
  end
  
end
