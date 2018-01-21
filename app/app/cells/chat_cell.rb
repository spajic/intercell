class ChatCell < Intercell
  include Layout::External

  def show
    render
  end

  def messages
    model
  end
end
