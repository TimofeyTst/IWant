class RoomsController < ApplicationController
  def index
    @users = current_user.initiators + current_user.recipients
  end

  def show
    @user = User.find(params[:id])
    @room_name = [get_name(@user), get_name(current_user, @user)]

    @single_room = Room.where(name: @room_name).first

    @message = Message.new
    @messages = @single_room.messages.order(created_at: :asc)

    @users = current_user.initiators + current_user.recipients
    render 'rooms/index'
  end

  def create
    @user = User.find(params[:id])
    @users = current_user.initiators + current_user.recipients

    @room_name = get_name(@user)
    @single_room = Room.where(name: @room_name).first || Room.create_room(current_user, @user, @room_name)

    @message = Message.new
    @messages = @single_room.messages.order(created_at: :asc)

    redirect_to chat_path(id: params[:id])
  end

  private

  def get_name(user, initiator = current_user)
    "private_#{initiator.id}_#{user.id}"
  end
end
