class ChatChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chat"
  end

  # Called when message-form contents are received by the server
  def send_message(payload)
    message = Message.new(author: current_user, text: payload["message"])
    if message.save
      ActionCable.server.broadcast "chat", message: render(message)
    end
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  private

  def render(message)
    MessageCell.new(message).show
  end
end
