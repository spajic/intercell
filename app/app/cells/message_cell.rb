class MessageCell < Intercell
  def show
    render
  end

  def message
    model
  end
end
