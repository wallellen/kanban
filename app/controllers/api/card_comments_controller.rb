module Api
  class CardCommentsController < ApplicationController
    respond_to :json

    def create
      card = current_user.cards.find(params[:card_comment][:card_id])
      params[:card_comment][:commenter_id] = current_user.id

      @comment = card.comments.build(params[:card_comment])
      unless @comment.save
        render nothing: true, status: :unprocessable_entity
      end      
    end

    def update
      @comment = CardComment.find(params[:id])
      @comment.content = params[:content]
      if @comment.save
        render json: @comment, status: :ok
      else
        render nothing: true, status: :unprocessable_entity
      end
    end
    
  end
end