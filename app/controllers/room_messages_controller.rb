class RoomMessagesController < ApplicationController
  before_action :load_entities

  def create
    @room_message = RoomMessage.create user: current_user,
                                       room: @room,
                                       message: params.dig(:room_message, :message),
                                       image: params.dig(:room_message, :image)

    RoomChannel.broadcast_to @room, @room_message
  end

  def destroy
    @room_message = RoomMessage.find(params.dig(:id)).delete
    ActiveStorage::Attachment.find_by(record_id: params.dig(:id)).purge
    #RoomChannel.broadcast_to @room, @room_message
  end

  def update
    @room_message = RoomMessage.find(params.dig(:id)).update(message: params.dig(:room_message, :message))
    #RoomChannel.broadcast_to @room, @room_message
  end

  protected

  def load_entities
    @room = Room.find params.dig(:room_message, :room_id)
  end
end
