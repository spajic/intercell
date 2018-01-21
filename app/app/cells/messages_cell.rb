class MessagesCell < Intercell
  def show
    render
  end

  def messages
    model
  end
end
