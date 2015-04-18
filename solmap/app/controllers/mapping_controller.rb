class MappingController < ApplicationController

	def county_data
		@county = County.find_by_name(params[:name])
	end

end
