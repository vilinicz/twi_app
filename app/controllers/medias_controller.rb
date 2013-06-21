class MediasController < ApplicationController
    before_filter :signed_in_user, only: :create

	def index
		@medias = Media.all
	end

	def new
		@media = Media.new
	end

	def create
	end


end
