class MicropostsController < ApplicationController
	before_filter :signed_in_user, only: [:create, :destroy]
    before_filter :correct_user,   only: :destroy

	def create
		@micropost = current_user.microposts.build(params[:micropost])
		respond_to do |format|
		  if @micropost.save
		  	@feed_items = current_user.feed.paginate(page: params[:page])
			format.html {redirect_to root_url}
			format.js   
		  else
			@feed_items = []
			format.html {render 'static_pages/home'}
			format.js   
		  end
	   end
	end

	def destroy
		@micropost = Micropost.find(params[:id])
		@micropost.destroy
        respond_to do |format|
        format.html { redirect_to root_url }
        format.json { head :no_content }
        format.js   #{ render :nothing => true }
      end
	end

	

	private

	  def correct_user
	  	@micropost = current_user.microposts.find_by_id(params[:id])
	  	redirect_to root_url if @micropost.nil?
	  end
end
