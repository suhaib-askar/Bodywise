class MemberController < ApplicationController

	before_action :get_member, only: [:index,:graph]

	def index
		@graphURL = member_graph_path(params.merge(:id => @user.id))
	end

	def graph
		limit = (params.has_key?(:limit) && params[:limit].to_i != 0) ? params[:limit].to_i : 7
		@weights = @user.weights.order('date_weighted DESC').limit(limit).reverse
		@graphURL = member_index_path(params.merge(:id => @user.id)) + '&limit=31' #default limit, will call this controller for json again, kinda weird, but think its ok?
	end

	private

    def get_member
      @user = User.find(params[:id])
    end

end
