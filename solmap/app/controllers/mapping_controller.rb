class MappingController < ApplicationController

	def county_data
		@county = County.find_by_name(params[:name])
	end

	def colors
		@county = County.find_by_name(params[:name])
		render json: @county
	end

end
