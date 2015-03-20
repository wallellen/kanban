module Api
  class BoardMembersController < ApplicationController
    respond_to :json

    def create
      board = current_user.boards.find(params[:board_id])
      user = User.find_by_email(params[:user_email])

      @member = board.boards_members.build({"member_id" => user.id})
      unless @member.save
        render nothing: true, status: :unprocessable_entity
      end
    end

    def destroy	
    end

  end
end