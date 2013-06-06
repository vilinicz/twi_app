class QuestsController < ApplicationController
	def index
      @quests = User.text_search(params[:search_text]) + Micropost.text_search(params[:search_text])
    end
end
