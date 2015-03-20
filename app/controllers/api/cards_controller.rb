module Api
  class CardsController < ApplicationController
    respond_to :json

    def index
      @cards = current_user.cards
    end

    def show
      @card = current_user.cards.find(params[:id])
      if @card.assignee_id == current_user.id or @card.board.is_admin(current_user) then
        @comments = @card.comments
      else
        @comments = @card.comments.select { |c| c.commenter_id == current_user.id }
      end
    end

    def create
      card = Card.new(params[:card])
      card.assignee = current_user
      if card.save
    		render json: card, status: :ok
      else
    		render nothing: true, status: :unprocessable_entity
      end
    end

    def update
    	card = current_user.cards.find(params[:id])
    	if card.update_attributes(params[:card])
        render json: card, status: :ok
      else
        render nothing: true, status: :unprocessable_entity
      end
    end

    def destroy
      card = current_user.cards.find(params[:id])
			if card.destroy
				render json: card, status: :ok
			else
				render nothing: true, status: :unprocessable_entity
			end
    end

    def sort
      @list = List.find(params[:list_id])
      card_ids = params[:card].map(&:to_i)

      # unless (card_ids - current_user.card_ids).empty?
      #   render nothing: true, status: :unauthorized
      # end

      card_ids.each_with_index do |id, index|
        Card.update_all({ position: index + 1,  list_id: @list.id },
                        { id: id })
      end

      @cards = @list.cards.where(id: card_ids)
    end

  end
end
