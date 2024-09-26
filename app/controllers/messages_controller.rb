class MessagesController < ApplicationController
  before_action :set_negotiation

  # Hotwire the shit out of this later on
  def create
    @message = @negotiation.messages.build(message_params)
    @message.user = current_user

    if @message.save
      redirect_to @negotiation, notice: 'Message was successfully sent.'
    else
      redirect_to @negotiation, alert: 'Failed to send message.'
    end
  end

  private

  def set_negotiation
    @negotiation = Negotiation.find(params[:negotiation_id])
  end

  def message_params
    params.require(:message).permit(:content)
  end
end
