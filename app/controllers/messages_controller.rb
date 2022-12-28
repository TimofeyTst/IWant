class MessagesController < ApplicationController
  def create
    @message = current_user.messages.create(body: msg_params[:body], chat_id: params[:id])
  end

  private

  def msg_params
    params.require(:message).permit(:body)
  end
end
