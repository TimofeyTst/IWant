class ChatsController < ApplicationController
  def index
    @users = current_user.initiators + current_user.recipients
  end

  def show
    @user = User.find(params[:id])
    @chat_name = [get_name(@user), get_name(current_user, @user)]

    @single_chat = Chat.where(name: @chat_name).first

    @message = Message.new
    @messages = @single_chat.messages.order(created_at: :asc)

    @users = current_user.initiators + current_user.recipients
    render 'chats/index'
  end

  def create
    @user = User.find(params[:id])
    @users = current_user.initiators + current_user.recipients

    @chat_name = [get_name(@user), get_name(current_user, @user)]
    @single_chat = Chat.where(name: @chat_name).first || Chat.create(
      initiator_id: current_user.id, recipient_id: @user.id, name: @chat_name.first
    )

    @message = Message.new
    @messages = @single_chat.messages.order(created_at: :asc)

    redirect_to chat_path(id: params[:id])
  end

  private

  def get_name(user, initiator = current_user)
    "private_#{initiator.id}_#{user.id}"
  end
end
